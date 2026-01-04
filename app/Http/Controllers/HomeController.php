<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HomeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = \DB::table('users')
            ->where('company_id', auth()->user()->company_id)
            ->where('role', '=', 'employee')
            ->count();

        $attend = \DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('date', date('Y-m-d'))
            ->where('status', '1')
            ->count();

        $sick = \DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('date', date('Y-m-d'))
            ->where('status', '2')
            ->count();

        $leave = \DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('date', date('Y-m-d'))
            ->where('status', '3')
            ->count();

        $alpa = \DB::table('attendance_headers')
            ->where('company_id', auth()->user()->company_id)
            ->where('date', date('Y-m-d'))
            ->where('status', '0')
            ->count();

        return response()->json([
            'employee' => $user,
            'attend' => $attend,
            'sick' => $sick,
            'leave' => $leave,
            'alpa' => $alpa,
        ], 200);
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
        //
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
