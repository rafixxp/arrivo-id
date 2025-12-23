<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PositionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $position = \DB::table('positions')->where('company_id', auth()->user()->company_id)->get();
        return response()->json($position);
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
            'name' => 'required'
        ]);

        $save = \DB::table('positions')->insert([
            'company_id' => auth()->user()->company_id,
            'name' => $request->name
        ]);

        if($save){
            return response()->json([
                'message' => 'Jabatan berhasil disimpan'
            ], 201);
        } else {
            return response()->json([
                'message' => 'Jabatan gagal disimpan'
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
            'name' => 'required'
        ]);
    
        $save = \DB::table('positions')->where('id', $id)->update([
            'company_id' => auth()->user()->company_id,
            'name' => $request->name
        ]);
    
        if($save){
            return response()->json([
                'message' => 'Jabatan berhasil disimpan'
            ], 201);
        } else {
            return response()->json([
                'message' => 'Jabatan gagal disimpan'
            ], 500);
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
