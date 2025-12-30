<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;
use Jenssegers\Agent\Agent;

date_default_timezone_set('Asia/Jakarta');

class AttendanceController extends Controller
{
    public function index()
    {
        // get schedules
        $schedule = \DB::table('schedules')
            ->where('schedules.user_id', auth()->user()->id)
            ->where('schedules.date', Carbon::now()->format('Y-m-d'))
            ->join('branches', 'schedules.branches_id', 'branches.id')
            ->leftJoin('attendance_headers', 'schedules.id', 'attendance_headers.schedule_id')
            ->select('schedules.*', 'branches.name as branch_name', 'schedules.clock_in as clock_in', 'schedules.clock_out as clock_out', 'attendance_headers.status as attendance_status')
            ->first();

        if(!$schedule){
            return response()->json([
                'status' => 'error',
                'message' => 'Jadwal belum diset, silahkan hubungi admin',
            ], 200);
        }
        else{
            $scheduleMap = [
                "date" => Carbon::parse($schedule->date)->locale('id')->isoFormat('dddd, D MMMM Y') ?? '',
                "branch_name" => $schedule->branch_name ?? '',
                "hour_name" => $schedule->shift ?? '',
                "clock_in" => Carbon::parse($schedule->clock_in)->format('H:i') ?? '',
                "clock_out" => Carbon::parse($schedule->clock_out)->format('H:i') ?? '',
                "status" => $schedule->attendance_status ?? '',
            ];
    
            $attendance = \DB::table('attendance_headers')
                ->where('user_id', auth()->user()->id)
                ->where('date', Carbon::now()->format('Y-m-d'))
                ->join('attendance_details', 'attendance_headers.id', 'attendance_details.attendance_id')
                ->select('attendance_details.time', 'attendance_details.attend', 'attendance_details.type', 'attendance_details.path')
                ->get();
    
            return response()->json([
                'schedule' => $scheduleMap,
                'attendance' => $attendance,
            ]);
        }

    }

    public function clockIn(Request $request)
    {
        $request->validate([
            'image' => 'required|string',
        ]);

        // agent
        $agent = new Agent();

        // ===== Decode Image =====
        $base64 = preg_replace('/^data:image\/\w+;base64,/', '', $request->image);
        $image = base64_decode($base64);

        $filename = 'clockin_' . time() . '.jpg';
        $path = 'clockin/' . $filename;

        // ===== Get Schedule =====
        $schedule = DB::table('schedules')
            ->where('user_id', auth()->id())
            ->where('date', date('Y-m-d'))
            ->select('schedules.id', 'schedules.late_time')
            ->first();

        if (!$schedule) {
            return response()->json(['message' => 'Jadwal tidak ditemukan'], 404);
        }

        // ===== Header =====
        $header = DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('user_id', auth()->id())
            ->where('date', date('Y-m-d'))
            ->first();

        if ($header) {
            $exists = DB::table('attendance_details')
                ->where('attendance_id', $header->id)
                ->where('type', 'clockin')
                ->exists();

            if ($exists) {
                return response()->json(['message' => 'Anda sudah Clock In'], 409);
            }
        }

        DB::beginTransaction();

        try {
            if (!$header) {
                $headerId = DB::table('attendance_headers')->insertGetId([
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => auth()->user()->branch_id,
                    'user_id' => auth()->id(),
                    'schedule_id' => $schedule->id,
                    'date' => date('Y-m-d'),
                    'type' => 'attendance',
                    'status' => 1
                ]);
            } else {
                $headerId = $header->id;
            }

            DB::table('attendance_details')->insert([
                'attendance_id' => $headerId,
                'company_id' => auth()->user()->company_id,
                'branch_id' => auth()->user()->branch_id,
                'time' => date('H:i:s'),
                'path' => asset('storage/' . $path),
                'attend' => date('H:i:s') > $schedule->late_time ? 'Terlambat' : 'Tepat Waktu',
                'type' => 'clockin',
                'ip_address' => $request->getClientIp(),
                'device' => trim($request->header('Sec-CH-UA-Model'), '"')." - ".trim($request->header('Sec-CH-UA-Platform'), '"'),
            ]);

            Storage::disk('public')->put($path, $image);

            DB::commit();

            return response()->json([
                'message' => 'Clock In berhasil',
                'path' => asset('storage/' . $path),
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Clock In gagal'], 500);
        }
    }

    public function clockOut(Request $request)
    {
        $request->validate([
            'image' => 'required|string',
        ]);

        $base64 = preg_replace('/^data:image\/\w+;base64,/', '', $request->image);
        $image = base64_decode($base64);

        $filename = 'clockout_' . time() . '.jpg';
        $path = 'clockout/' . $filename;

        // ===== Schedule =====
        $schedule = DB::table('schedules')
            ->where('user_id', auth()->id())
            ->where('date', date('Y-m-d'))
            ->select('schedules.id', 'schedules.clock_out')
            ->first();

        if (!$schedule) {
            return response()->json(['message' => 'Jadwal tidak ditemukan'], 404);
        }

        // ===== Header WAJIB ADA =====
        $header = DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('user_id', auth()->id())
            ->where('date', date('Y-m-d'))
            ->first();

        if (!$header) {
            return response()->json([
                'message' => 'Silakan Clock In terlebih dahulu'
            ], 409);
        }

        $exists = DB::table('attendance_details')
            ->where('attendance_id', $header->id)
            ->where('type', 'clockout')
            ->exists();

        if ($exists) {
            return response()->json(['message' => 'Anda sudah Clock Out'], 409);
        }

        DB::beginTransaction();

        try {
            DB::table('attendance_details')->insert([
                'attendance_id' => $header->id,
                'company_id' => auth()->user()->company_id,
                'branch_id' => auth()->user()->branch_id,
                'time' => date('H:i:s'),
                'path' => asset('storage/' . $path),
                'attend' => date('H:i:s') < $schedule->clock_out
                    ? 'Terlalu Awal'
                    : 'Tepat Waktu',
                'type' => 'clockout',
                'ip_address' => $request->getClientIp(),
                'device' => trim($request->header('Sec-CH-UA-Model'), '"')." - ".trim($request->header('Sec-CH-UA-Platform'), '"'),

            ]);

            Storage::disk('public')->put($path, $image);

            DB::commit();

            return response()->json([
                'message' => 'Clock Out berhasil',
                'path' => asset('storage/' . $path),
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Clock Out gagal'], 500);
        }
    }

    public function getAttendance(Request $request)
    {
        $attendance = \DB::table('attendance_headers as ah')
            ->where('ah.company_id', auth()->user()->company_id)
            ->where('ah.type', 'attendance')
            ->where('ah.status', '1')
            ->when($request->has('filter'), function ($query) use ($request) {
                switch($request->filter) {
                    case 'today':
                        return $query->where('ah.date', Carbon::today()->toDateString());
                    case 'week':
                        return $query->whereBetween('ah.date', [
                            Carbon::now()->startOfWeek()->toDateString(),
                            Carbon::now()->endOfWeek()->toDateString()
                        ]);
                    case 'month':
                        return $query->whereBetween('ah.date', [
                            Carbon::now()->startOfMonth()->toDateString(),
                            Carbon::now()->endOfMonth()->toDateString()
                        ]);
                    default:
                        return $query->where('ah.date', Carbon::today()->toDateString());
                }
            })
            ->when(!$request->has('filter'), function ($query) {
                return $query->where('ah.date', Carbon::today()->toDateString());
            })
            ->join('users as u', 'ah.user_id', 'u.id')
            ->leftJoin('attendance_details as ad', 'ah.id', 'ad.attendance_id')
            ->select(
                'ah.id',
                'ah.user_id',
                'ah.date',
                'u.name',
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.time END) as clock_in"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.path END) as clockin_photo"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.attend END) as clockin_attend"),
            )
            ->groupBy('ah.id', 'ah.user_id', 'ah.date', 'u.name')
            ->get();

        $data = [];

        foreach($attendance as $a){
            $data[] = [
                'id' => $a->id,
                'user_id' => $a->user_id,
                'date' => Carbon::parse($a->date)->locale('id')->translatedFormat('D, d F Y'),
                'name' => $a->name,
                'clockin_photo' => $a->clockin_photo,
                'clockin_attend' => $a->clockin_attend
            ];
        }

        return response()->json($data, 200);
    }

    public function attendanceDetail($id)
    {
        $detail = \DB::table('attendance_details')
            ->where('attendance_details.attendance_id', $id)
            ->join('branches', 'attendance_details.branch_id', 'branches.id')
            ->select('attendance_details.id','attendance_details.type','attendance_details.time','attendance_details.path','attendance_details.attend','attendance_details.ip_address', 'attendance_details.device', 'branches.name as branch_name')
            ->get();

        return response()->json($detail, 200);
    }

    public function getUserSchedule()
    {
        $schedule = \DB::table('schedules')
            ->where('company_id', auth()->user()->company_id)
            ->where('user_id', auth()->user()->id)
            ->select('shift', 'date', 'clock_in', 'clock_out')
            ->get();

        $data = [];
        foreach($schedule as $map){
            $data[] = [
                'shift' => $map->shift,
                'date' => Carbon::parse($map->date)->locale('id')->translatedFormat('D, d F Y'),
                'clock_in' => Carbon::parse($map->clock_in)->translatedFormat('H:i'),
                'clock_out' => Carbon::parse($map->clock_out)->translatedFormat('H:i'),
            ];
        }

        return response()->json($data, 200);
    }

    public function attendanceRecap()
    {
        $count = \DB::table('attendance_headers')
            ->where('attendance_headers.company_id', auth()->user()->company_id)
            ->leftJoin('users', 'attendance_headers.user_id', 'users.id')
            ->leftJoin('attendance_details', 'attendance_headers.id', 'attendance_details.attendance_id')
            ->select(
                'users.name',
                \DB::raw("COUNT(CASE WHEN attendance_headers.status = '1' THEN 1 END) as present_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Tepat Waktu' THEN 1 END) as on_time_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Terlambat' THEN 1 END) as late_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Terlalu Awal' THEN 1 END) as early_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Sakit' THEN 1 END) as sick_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Izin' THEN 1 END) as late_count"),
                \DB::raw("COUNT(CASE WHEN attendance_details.attend = 'Cuti' THEN 1 END) as early_count"),
                // \DB::raw("COUNT(CASE WHEN attendance_headers.status = null THEN 1 END) as absent_count")
            )
            ->groupBy('users.name')
            ->get();

        return response()->json($count, 200);
    }
}