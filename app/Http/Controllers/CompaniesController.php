<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CompaniesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $data = \DB::table('companies')->where('id', 1)->first();
        return response()->json($data);
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
            'name' => 'required|string',
            'address' => 'required|string',
            'npwp' => 'required',
            'email' => 'required|email',
            'domain' => 'required',
        ]);

        $company = \DB::table('companies')->insert([
            'name' => $request->name,
            'address' => $request->address,
            'npwp' => $request->npwp,
            'email' => $request->email,
            'domain' => $request->domain,
        ]);

        if($company){
            return response()->json(['message' => 'Company created successfully'], 201);
        } else {
            return response()->json(['message' => 'Failed to create company'], 500);
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
