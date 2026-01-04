<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Models\User;

class ScheduleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $schedules = DB::table('schedules')
            ->where('schedules.company_id', auth()->user()->company_id)
            ->join('branches', 'schedules.branches_id', 'branches.id')
            ->join('users', 'schedules.user_id', 'users.id')
            ->select(
                'schedules.id',
                'schedules.date',
                'schedules.shift',
                'schedules.status',
                'schedules.clock_in',
                'schedules.late_time',
                'schedules.clock_out',
                'schedules.hour_id as hour_id',
                'branches.name as branch_name',
                'users.id as user_id',
                'users.name as user_name',
            )
            ->orderBy('users.name')
            ->orderBy('schedules.date')
            ->get();
        
        $result = $schedules->groupBy('user_id')->map(function ($items) {
            return [
                'user_name' => $items->first()->user_name,
                'user_id' => $items->first()->user_id,
                'schedules' => $items->map(function ($row) {
                    return [
                        'date'        => $row->date,
                        'status'      => $row->status,
                        'branch_name' => $row->branch_name,
                        'hour_id'     => $row->hour_id,
                        'hour_name'   => $row->shift,
                        'clock_in'    => Carbon::parse($row->clock_in)->locale('id')->translatedFormat('H.i'),
                        'clock_out'   => Carbon::parse($row->clock_out)->locale('id')->translatedFormat('H.i'),
                    ];
                })->values()
            ];
        })->values();

        $dates = \DB::table('schedules')
            ->where('company_id', auth()->user()->company_id)
            ->select('date')
            ->groupBy('date')
            ->pluck('date')
            ->toArray();

        $date = [];

        foreach($dates as $d)
        {
            $date[] = [
                $d,
                Carbon::parse($d)->locale('id')->translatedFormat('D, d F Y')
            ];
        }

        return response()->json([
            'data' => $result,
            'dates' => $date
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'branch_id' => 'required',
            'hour_id' => 'required',
            'employee_id' => 'required',
            'start_date' => 'required',
            'end_date' => 'required',
        ]);

        $users = \DB::table('users')
            ->where('users.company_id', auth()->user()->company_id)
            ->when($request->branch_id !== 'all', function ($q) use ($request){
                $q->where('users.branch_id', $request->branch_id);
            })
            ->when($request->employee_id !== 'all', function ($q) use ($request){
                $q->where('users.id', $request->employee_id);
            })
            ->when($request->hour_id !== 'all', function ($q) use ($request){
                $q->where('users.hour_id', $request->hour_id);
            })
            ->leftJoin('hours', 'users.hour_id', 'hours.id')
            ->select('users.branch_id', 'users.id', 'hours.id as hour_id', 'hours.name as shift', 'hours.clock_in', 'hours.clock_out', 'hours.late_time')
            ->get();

        $data = [];
        $headers = [];

        $period = Carbon::parse($request->start_date)->toPeriod($request->end_date);

        foreach($users as $user){
            foreach($period as $date){

                $save = \DB::table('schedules')->insertGetId([
                    'company_id' => auth()->user()->company_id,
                    'branches_id' => $user->branch_id,
                    'user_id' => $user->id,
                    'date' => $date->format('Y-m-d'),
                    'shift' => $user->shift,
                    'clock_in' => $user->clock_in,
                    'late_time' => $user->late_time,
                    'clock_out' => $user->clock_out,
                    'hour_id' => $user->hour_id,
                    'status' => 1,
                ]);
                
                $headers[] = [
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => $user->branch_id,
                    'user_id' => $user->id,
                    'date' => $date->format('Y-m-d'),
                    'schedule_id' => $save,
                    'status' => 0,
                    'type' => 'attendance'
                ];
            }
        }

        $save = \DB::table('attendance_headers')->insert($headers);

        if ($save) {
            return response()->json(['message' => 'Jadwal berhasil digenerate'], 201);
        } else {
            return response()->json(['message' => 'Jadwal gagal digenerate karena data duplikat atau kesalahan database'], 500);
        }
    }

    public function addSchedule(Request $request)
    {
        $request->validate([
            'employee_id' => 'required',
            'hour_id' => 'required',
            'start_date' => 'required',
            'end_date' => 'required',
        ]);

        $user = \DB::table('users')
            ->where('users.company_id', auth()->user()->company_id)
            ->where('users.id', $request->employee_id)
            ->leftJoin('hours', 'users.hour_id', 'hours.id')
            ->select('users.branch_id', 'users.id', 'hours.id as hour_id', 'hours.name as shift', 'hours.clock_in', 'hours.clock_out', 'hours.late_time')
            ->first();

        if (!$user) {
            return response()->json(['message' => 'Karyawan tidak ditemukan'], 404);
        }

        $period = Carbon::parse($request->start_date)->toPeriod($request->end_date);

        $data;
        $headers;

        foreach($period as $date){
            $data = \DB::table('schedules')->insertGetId([
                    'company_id' => auth()->user()->company_id,
                    'branches_id' => $user->branch_id,
                    'user_id' => $user->id,
                    'date' => $date->format('Y-m-d'),
                    'shift' => $user->shift,
                    'clock_in' => $user->clock_in,
                    'late_time' => $user->late_time,
                    'clock_out' => $user->clock_out,
                    'hour_id' => $user->hour_id,
                    'status' => 1,
                ]); 

            $headers =DB::table('attendance_headers')->insert([
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => $user->branch_id,
                    'user_id' => $user->id,
                    'date' => $date->format('Y-m-d'),
                    'schedule_id' => $data,
                    'status' => 0,
                    'type' => 'attendance'
                ]);
        }

        return response()->json(['message' => 'Jadwal berhasil ditambahkan !'], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request)
    {
        $request->validate([
            'hour_id' => 'required',
            'date' => 'required|date',
            'employee_id' => 'required',
            'is_active' => 'required'
        ]);

        $hour = \DB::table('hours')
            ->where('company_id', auth()->user()->company_id)
            ->where('id', $request->hour_id)
            ->first();

        $schedules = \DB::table('schedules')
            ->where('company_id', auth()->user()->company_id)
            ->where('user_id', $request->employee_id)
            ->where('date', $request->date)
            ->update([
                'shift' => $hour->name,
                'clock_in' => $hour->clock_in,
                'late_time' => $hour->late_time,
                'clock_out' => $hour->clock_out,
                'hour_id' => $request->hour_id,
                'status' => $request->is_active
            ]);
        
        if($schedules){
            return response()->json(['message' => 'Jadwal berhasil diubah !'], 200);
        }else{
            return response()->json(['message' => 'Jadwal gagal diubah !'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
