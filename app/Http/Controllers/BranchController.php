<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BranchController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $branch = \DB::table('branches')->where('company_id', auth()->user()->company_id)->get();
        return response()->json($branch);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //login
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'address' => 'required|string',
        ]);

        $save = \DB::table('branches')->insert([
            'company_id' => auth()->user()->company_id,
            'name' => $request->name,
            'address' => $request->address,
        ]);

        if($save){
            return response()->json(['message' => 'Branch created successfully'], 201);
        } else {
            return response()->json(['message' => 'Failed to create branch'], 500);
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
            'id' => 'required',
            'name' => 'required|string',
            'address' => 'required|string',
        ]);
    
        $save = \DB::table('branches')->where('id', $id)->update([
            'company_id' => auth()->user()->company_id,
            'name' => $request->name,
            'address' => $request->address,
        ]);
    
        if($save){
            return response()->json(['message' => 'Cabang berhasil diubah !']);
        } else {
            return response()->json(['message' => 'Cabang gagal diubah !'], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $delete = \DB::table('branches')->where('id', $id)->delete();
        if($delete){
            return response()->json(['message' => 'Cabang berhasil dihapus !']);
        } else {
            return response()->json(['message' => 'Cabang gagal dihapus !'], 500);
        }
    }
}
