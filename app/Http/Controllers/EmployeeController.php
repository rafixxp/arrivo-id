<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use App\Models\User;

class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $user = \DB::table('users')
            ->where('company_id', auth()->user()->company_id)
            ->when(auth()->user()->role === 'admin' || auth()->user()->role === 'super admin', function($query) {
                // No filtering needed for admin/super admin
            }, function($query) {
                $query->where('role', 'employee');
            })
            ->simplePaginate(10);
        return response()->json($user,200);
    }
    
    public function all()
    {
        $user = \DB::table('users')
            ->where('company_id', auth()->user()->company_id)
            ->where('role', 'employee')
            ->select('name', 'id')
            ->get();
            
        return response()->json([
            'status' => 'success',
            'data' => $user,
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
        $request->validate([
            'branch_id' => 'required',
            'name' => 'required|string',
            'email' => 'required|email',
            'phone' => 'required',
            'position_id' => 'required',
            'address' => 'required|string',
            'date_of_birth' => 'required|date',
            'place_of_birth' => 'required|string',
            'hours_id' => 'required',
            // 'password' => 'string|min:4',
        ]);

        $employee = \DB::table('users')->insert([
            'company_id' => auth()->user()->company_id,
            'branch_id' => $request->branch_id,
            'name' => $request->name,
            'email' => $request->email, 
            'position_id' => $request->position_id, 
            'address' => $request->address, 
            'date_of_birth' => $request->date_of_birth, 
            'place_of_birth' => $request->place_of_birth,
            'phone' => $request->phone,
            'role' => $request->role, 
            'hour_id' => $request->hours_id, 
            'password' => $request->password ? Hash::make($request->password) : Hash::make('password123'), 
        ]);

        if($employee){
            return response()->json([
                'status' => 'success',
                'message' => 'Employee created successfully',
            ], 201);
        }
        else{
            return response()->json([
                'status' => 'error',
                'message' => 'Employee creation failed',
            ], 500);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $user = \DB::table('users')
                ->where('users.id', $id)
                ->select('positions.name as position_id','users.id', 'users.branch_id', 'users.name', 'users.email', 'users.phone', 'users.address', 'users.date_of_birth', 'users.place_of_birth', 'users.role')
                ->leftJoin('positions', 'users.position_id','positions.id')
                ->first();

        $user->date_of_birth = \Carbon\Carbon::parse($user->date_of_birth)->locale('id')->translatedFormat('d F Y');

        return response()->json($user, 200);
    }
    
    /**
     * Show the form for editing the specified resource.
    */
    public function edit(string $id)
    {
        $user = \DB::table('users')
                ->select('id', 'position_id','branch_id', 'name', 'email', 'phone', 'position_id', 'address', 'date_of_birth', 'place_of_birth', 'role')
                ->where('id', $id)
                ->first();
        return response()->json($user, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'branch_id' => 'required',
            'name' => 'required|string',
            'email' => 'required|email',
            'phone' => 'required',
            'position_id' => 'required',
            'address' => 'required|string',
            'date_of_birth' => 'required|date',
            'place_of_birth' => 'required|string',
            // 'password' => 'string|min:4',
        ]);

        $employee = \DB::table('users')->where('id', $id)->update([
            'branch_id' => $request->branch_id,
            'name' => $request->name,
            'email' => $request->email, 
            'position_id' => $request->position_id, 
            'address' => $request->address, 
            'date_of_birth' => $request->date_of_birth, 
            'place_of_birth' => $request->place_of_birth,
            'phone' => $request->phone,
            'password' => $request->passwords ? Hash::make($request->passwords) : \DB::table('users')->where('id', $id)->value('password'), 
        ]);

        if($employee){
            return response()->json([
                'status' => 'success',
                'message' => 'Employee updated successfully',
            ], 200);
        }
        else{
            return response()->json([
                'status' => 'error',
                'message' => 'Employee update failed',
            ], 500);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $employee = \DB::table('users')->where('id', $id)->delete();
        if($employee){
            return response()->json([
                'message' => 'Employee deleted successfully'
            ]);
        }
        else{
            return response()->json([
                'message' => 'Employee delete failed'
            ]);
        }
    }
}
