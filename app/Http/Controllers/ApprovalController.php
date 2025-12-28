<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ApprovalController extends Controller
{
    public function index()
    {
        $header = \DB::table('attendance_headers')
            ->where('attendance_headers.user_id', auth()->user()->id)
            ->where('attendance_headers.type', 'leave')
            ->leftJoin('approvals', 'attendance_headers.id', 'approvals.attendance_id')
            ->select('attendance_headers.id', 'attendance_headers.date', 'approvals.type', 'approvals.status', 'approvals.notes')
            ->get();

        $leave = [];

        foreach($header as $data){
            $leave[] = [
                'id' => $data->id,
                'date' => Carbon::parse($data->date)->locale('id')->translatedFormat('D, d F Y'),
                'type' => $data->type,
                'status' => $data->status,
                'notes' => $data->notes
            ];
        }

        return response()->json($leave, 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'type' => 'required',
            'from_date' => 'required',
            'to_date' => 'required',
            'note' => 'required',
        ]);

        $header = \DB::table('attendance_headers')
            ->where('user_id', auth()->user()->id)
            ->where('date', Carbon::now()->format('Y-m-d'))
            ->first();

        if($header){
            $id = $header->id;

            $details = \DB::table('approvals')
                ->insert([
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => auth()->user()->branch_id,
                    'employee_id' => auth()->user()->id,
                    'attendance_id' => $header,
                    'type' => $request->type,
                    'start_date' => $request->from_date,
                    'end_date' => $request->to_date,
                    'notes' => $request->note,
                    'status' => 'pending'
                ]);

            return response()->json([
                'status' => 'success',
                'message' => 'Approval created successfully',
            ], 201);
            
        }
        else{
            $header = \DB::table('attendance_headers')
                ->insertGetId([
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => auth()->user()->branch_id,
                    'user_id' => auth()->user()->id,
                    'date' => Carbon::now()->format('Y-m-d'),
                    'type' => 'leave',
                    'status' => 1
                ]);
            
            $details = \DB::table('approvals')
                ->insert([
                    'company_id' => auth()->user()->company_id,
                    'branch_id' => auth()->user()->branch_id,
                    'employee_id' => auth()->user()->id,
                    'attendance_id' => $header,
                    'type' => $request->type,
                    'start_date' => $request->from_date,
                    'end_date' => $request->to_date,
                    'notes' => $request->note,
                    'status' => 'pending'
                ]);

            return response()->json([
                'status' => 'success',
                'message' => 'Approval created successfully',
            ], 201);
        }
    }

    public function show($id)
    {
        $data = \DB::table('approvals')
            ->where('attendance_id', $id)
            ->first();

        $approval = [
            'id' => $data->id,
            'type' => $data->type ?: null,
            'start_date' => Carbon::parse($data->start_date)->locale('id')->translatedFormat('d F Y'),
            'end_date' => Carbon::parse($data->end_date)->locale('id')->translatedFormat('d F Y'),
            'duration' => Carbon::parse($data->start_date)->diffInDays(Carbon::parse($data->end_date)) + 1,
            'notes' => $data->notes ?: null,
            'approved_notes' => $data->approved_notes ?: null,
            'approved_by' => $data->approved_by ?: null,
            'status' => $data->status ?: null
        ];

        return response()->json($approval, 200);
    }

    public function list()
    {
        $approval = \DB::table('attendance_headers')
            ->where('attendance_headers.type', 'leave')
            ->leftJoin('approvals', 'attendance_headers.id', 'approvals.attendance_id')
            ->leftJoin('users', 'attendance_headers.user_id', 'users.id')
            ->select('attendance_headers.id', 'attendance_headers.date', 'approvals.type', 'approvals.status', 'approvals.notes', 'users.name')
            ->get();

        return response()->json($approval, 200);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'notes' => 'required',
        ]);

        $update = \DB::table('approvals')
            ->where('id', $id)
            ->update([
                'approved_notes' => $request->notes,
                'status' => $request->status,
                'approved_by' => auth()->user()->name
            ]);
    }

}
