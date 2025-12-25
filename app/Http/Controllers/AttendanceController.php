<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

date_default_timezone_set('Asia/Jakarta');

class AttendanceController extends Controller
{
    public function index()
    {
        // get schedules
        $schedule = \DB::table('schedules')
            ->where('user_id', auth()->user()->id)
            ->where('date', Carbon::now()->format('Y-m-d'))
            ->join('branches', 'schedules.branches_id', 'branches.id')
            ->join('hours', 'schedules.hours_id', 'hours.id')
            ->select('schedules.*', 'branches.name as branch_name','hours.name as hour_name', 'hours.clock_in as clock_in', 'hours.clock_out as clock_out')
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
                "hour_name" => $schedule->hour_name ?? '',
                "clock_in" => Carbon::parse($schedule->clock_in)->format('H:i') ?? '',
                "clock_out" => Carbon::parse($schedule->clock_out)->format('H:i') ?? '',
                "status" => $schedule->status ?? '',
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

        // ===== Decode Image =====
        $base64 = preg_replace('/^data:image\/\w+;base64,/', '', $request->image);
        $image = base64_decode($base64);

        $filename = 'clockin_' . time() . '.jpg';
        $path = 'clockin/' . $filename;

        // ===== Get Schedule =====
        $schedule = DB::table('schedules')
            ->where('user_id', auth()->id())
            ->where('date', date('Y-m-d'))
            ->join('hours', 'schedules.hours_id', 'hours.id')
            ->select('schedules.id', 'hours.late_time')
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
            ->join('hours', 'schedules.hours_id', 'hours.id')
            ->select('schedules.id', 'hours.clock_out')
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

    public function getAttendance()
    {
        $attendance = \DB::table('attendance_headers as ah')
            ->where('ah.company_id', auth()->user()->company_id)
            ->where('ah.date', date('Y-m-d'))
            ->join('users as u', 'ah.user_id', 'u.id')
            ->leftJoin('attendance_details as ad', 'ah.id', 'ad.attendance_id')
            ->select(
                'ah.id',
                'ah.user_id',
                'u.name',
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.time END) as clock_in"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockout' THEN ad.time END) as clock_out"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.path END) as clockin_photo"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockout' THEN ad.path END) as clockout_photo"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockin' THEN ad.attend END) as clockin_attend"),
                \DB::raw("MAX(CASE WHEN ad.type = 'clockout' THEN ad.attend END) as clockout_attend")
            )
            ->groupBy('ah.id', 'ah.user_id', 'u.name')
            ->get();

        return response()->json($attendance, 200);
    }
}