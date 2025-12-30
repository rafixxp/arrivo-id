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
                'branches.name as branch_name',
                'users.id as user_id',
                'users.name as user_name'
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
                        'hour_name'   => $row->shift,
                        'clock_in'    => $row->clock_in,
                        'clock_out'   => $row->clock_out,
                    ];
                })->values()
            ];
        })->values();

        $date = \DB::table('schedules')
            ->where('company_id', auth()->user()->company_id)
            ->select('date')
            ->groupBy('date')
            ->pluck('date')
            ->toArray();

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

        $usersQuery = \DB::table('users')
            ->where('users.company_id', auth()->user()->company_id);

        // Filter branch jika tidak all
        if ($request->branch_id !== 'all') {
            $usersQuery->where('users.branch_id', $request->branch_id);
        }
        // Filter employee jika tidak all
        if ($request->employee_id !== 'all') {
            $usersQuery->where('users.id', $request->employee_id);
        }
        // Join hours jika hour_id tidak all
        if ($request->hour_id !== 'all') {
            $usersQuery->leftJoin('hours', 'users.hour_id', 'hours.id');
            $usersQuery->select('users.branch_id', 'users.id', 'hours.name as shift', 'hours.clock_in', 'hours.clock_out', 'hours.late_time');
        } else {
            $usersQuery->select('users.branch_id', 'users.id', \DB::raw('NULL as shift'), \DB::raw('NULL as clock_in'), \DB::raw('NULL as clock_out'), \DB::raw('NULL as late_time'));
        }
        $users = $usersQuery->get();

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
                    'status' => 1,
                ]);
                
                $headers[] = [
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => auth()->user()->branch_id,
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
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
