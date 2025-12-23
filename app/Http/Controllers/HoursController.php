<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class HoursController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $hours = \DB::table('hours')->get();
        return response()->json($hours);
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
            'name' => 'required',
            'clock_in' => 'required',
            'late' => 'required',
            'clock_out' => 'required',
        ]);

        $save = \DB::table('hours')->insert([
            'company_id' => auth()->user()->company_id,
            'branches_id' => auth()->user()->branch_id,
            'name' => $request->name,
            'clock_in' => $request->clock_in,
            'late_time' => $request->late,
            'clock_out' => $request->clock_out,
        ]);

        if($save){
            return response()->json([
                'status' => true,
                'message' => 'Data berhasil disimpan'
            ], 201);
        }
        else{
            return response()->json([
                'status' => false,
                'message' => 'Gagal menyimpan data'
            ], 500);
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
        $request->validate([
            'name' => 'required',
            'clock_in' => 'required',
            'late' => 'required',
            'clock_out' => 'required',
        ]);
    
        $save = \DB::table('hours')->where('id', $id)->update([
            'company_id' => auth()->user()->company_id,
            'branches_id' => auth()->user()->branch_id,
            'name' => $request->name,
            'clock_in' => $request->clock_in,
            'late_time' => $request->late,
            'clock_out' => $request->clock_out,
        ]);
    
        if($save){
            return response()->json([
                'status' => true,
                'message' => 'Data berhasil diupdate'
            ], 201);
        }
        else{
            return response()->json([
                'status' => false,
                'message' => 'Gagal mengupdate data'
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        
    }
}
