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
            ->join('hours', 'schedules.hours_id', 'hours.id')
            ->join('users', 'schedules.user_id', 'users.id')
            ->select(
                'schedules.id',
                'schedules.date',
                'schedules.shift',
                'schedules.status',
                'branches.name as branch_name',
                'hours.clock_in as clock_in',
                'hours.clock_out as clock_out',
                'hours.name as hour_name',
                'users.id as user_id',
                'users.name as user_name'
            )
            ->orderBy('users.name')
            ->orderBy('schedules.date')
            ->get();
        
        $result = $schedules->groupBy('user_id')->map(function ($items) {
            return [
                'user_name' => $items->first()->user_name,
                'schedules' => $items->map(function ($row) {
                    return [
                        'date'        => $row->date,
                        'shift'       => $row->shift,
                        'status'      => $row->status,
                        'branch_name' => $row->branch_name,
                        'hour_name'   => $row->hour_name,
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

        $users = \DB::table('users')
            ->where('company_id', auth()->user()->company_id)
            ->when($request->branch_id !== 'all', function ($query) use ($request) {
                $query->where('branch_id', $request->branch_id);
            })
            ->when($request->employee_id !== 'all', function ($query) use ($request) {
                $query->where('id', $request->employee_id);
            })
            ->get();

        $data = [];

        $period = Carbon::parse($request->start_date)->toPeriod($request->end_date);

        foreach($users as $user){
            foreach($period as $date){
                $data[] = [
                    'company_id' => auth()->user()->company_id,
                    'branches_id' => $user->branch_id,
                    'user_id' => $user->id,
                    'date' => $date->format('Y-m-d'),
                    'hours_id' => $user->hours_id
                ];
            }
        }

        $save = \DB::table('schedules')->insert($data);

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
