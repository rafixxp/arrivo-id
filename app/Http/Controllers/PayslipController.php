<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PayslipController extends Controller
{
    public function index()
    {
        $payslip = \DB::table('payslip_headers')
            ->where('company_id', auth()->user()->company_id)
            ->get();

        return response()->json($payslip, 200);
    }

    public function criteria()
    {
        $criteria = \DB::table('criteria')
            ->get();

        return response()->json($criteria, 200);
    }

    public function component()
    {
        $comp = \DB::table('payslip_components')
            ->where('company_id', auth()->user()->company_id)
            ->get();

        return response()->json($comp, 200);
    }

    public function storeComponent(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'type' => 'required|string',
            'criteria_id' => 'required',
            // 'time_id' => 'required',
            'quantity' => 'required'
        ]);

        $store = \DB::table('payslip_components')->insert([
            'company_id' => auth()->user()->company_id,
            'branch_id' => auth()->user()->branch_id,
            'name' => $request->name,
            'type' => $request->type,
            'criteria_id' => $request->criteria_id,
            'time_id' => 1,
            'quantity' => $request->quantity,
        ]);

        if($store){
            return response()->json(['message' => 'component added !'], 201);
        }
        else{
            return response()->json(['message' => 'component failed to save'], 500);
        }
    }

    public function generateComponent(Request $request)
    {
        try {
            \DB::transaction(function () {

                $employees = \DB::table('users')
                    ->where('company_id', auth()->user()->company_id)
                    ->get();

                $components = \DB::table('payslip_components')
                    ->where('company_id', auth()->user()->company_id)
                    ->get();

                foreach ($employees as $emp) {

                    $header = \DB::table('payslip_setting_headers')
                        ->where('company_id', auth()->user()->company_id)
                        ->where('user_id', $emp->id)
                        ->first();

                    $headerId = $header?->id ?? \DB::table('payslip_setting_headers')
                        ->insertGetId([
                            'company_id' => auth()->user()->company_id,
                            'branch_id' => $emp->branch_id,
                            'user_id' => $emp->id,
                            'nama' => $emp->name,
                            'is_active' => 1,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);

                    foreach ($components as $c) {
                        $exists = \DB::table('payslip_setting_details')
                            ->where('company_id', auth()->user()->company_id)
                            ->where('component_id', $c->id)
                            ->where('user_id', $emp->id)
                            ->exists();

                        if (!$exists) {
                            \DB::table('payslip_setting_details')->insert([
                                'company_id' => auth()->user()->company_id,
                                'branch_id' => $emp->branch_id,
                                'payslip_id' => $headerId,
                                'user_id' => $emp->id,
                                'component_id' => $c->id,
                                'name' => $c->name,
                                'type' => $c->type,
                                'criteria_id' => $c->criteria_id,
                                'time_id' => $c->time_id,
                                'quantity' => $c->quantity,
                                'value' => 0,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ]);
                        }
                    }
                }
            });

            return response()->json([
                'status' => 'success',
                'message' => 'Payslip component successfully generated for all employees'
            ], 200);

        } catch (\Throwable $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Failed to generate payslip component',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function setting()
    {
        $setting = \DB::table('payslip_setting_headers')
            ->leftJoin('branches', 'payslip_setting_headers.branch_id', '=', 'branches.id')
            ->where('payslip_setting_headers.company_id', auth()->user()->company_id)
            ->select('payslip_setting_headers.*', 'branches.name as branch_name')
            ->get();
        
        return response()->json($setting, 200);
    }

    public function times()
    {
        $times = \DB::table('times')
            ->get();

        return response()->json($times, 200);
    }

    public function settingDetail($id)
    {
        $user = \DB::table('payslip_setting_headers')
            ->where('payslip_setting_headers.company_id', auth()->user()->company_id)
            ->where('payslip_setting_headers.id', $id)
            ->leftJoin('users','payslip_setting_headers.user_id','users.id')
            ->select('users.name', 'users.email')
            ->first();

        $detail = \DB::table('payslip_setting_details')
            ->where('payslip_setting_details.payslip_id', $id)
            ->join('times', 'payslip_setting_details.time_id','times.id')
            ->select('payslip_setting_details.id','payslip_setting_details.name','payslip_setting_details.value','payslip_setting_details.time_id','times.name as time_name')
            ->get();

        return response()->json([
            'user' => $user,
            'details' => $detail
        ], 200);
    }

    public function editDetail(Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
            'time_id' => 'required',
            'value' => 'required|numeric'
        ]);

        $update = \DB::table('payslip_setting_details')
            ->where('company_id', auth()->user()->company_id)
            ->where('id', $id)
            ->update([
                'name' => $request->name,
                'time_id' => $request->time_id,
                'value' => $request->value,
                'updated_at' => now()
            ]);

        if($update){
            return response()->json(['message' => 'Detail payslip berhasil diperbarui'], 200);
        }
        else{
            return response()->json(['message' => 'Detail payslip gagal diperbarui'], 500);
        }       
    }

    public function generatePayslip(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'start_from' => 'required|date',
            'end_at' => 'required|date',
        ]);

        $header = \DB::table('payslip_headers')
            ->insertGetId([
                'company_id' => auth()->user()->company_id,
                'branch_id' => auth()->user()->branch_id,
                'user_id' => auth()->user()->id,
                'name' => $request->name,
                'start_from' => $request->start_from,
                'end_at' => $request->end_at,
                'created_at' => now(),
                'updated_at' => now()
            ]);

        if($header){
            /* prepare setting data */
            $users = \DB::table('users')
                ->where('company_id', auth()->user()->company_id)
                ->select('id', 'name', 'branch_id')
                ->get();

            foreach($users as $user)
            {
                $attend = \DB::table('attendance_headers')
                            ->where('user_id', $user->id)
                            ->whereBetween('date', [$request->start_from, $request->end_at])
                            ->join('attendance_details','attendance_headers.id','attendance_details.attendance_id')
                            ->count();
                            
                $absence = \DB::table('attendance_headers')
                            ->where('attendance_headers.user_id', $user->id)
                            ->whereBetween('date', [$request->start_from, $request->end_at])
                            ->rightJoin('approvals','attendance_headers.id','approvals.attendance_id')
                            ->count();

                $sick = \DB::table('attendance_headers')
                            ->where('attendance_headers.user_id', $user->id)
                            ->where('approvals.type', 'sakit')
                            ->whereBetween('date', [$request->start_from, $request->end_at])
                            ->rightJoin('approvals','attendance_headers.id','approvals.attendance_id')
                            ->count();

                $leave = \DB::table('attendance_headers')
                            ->where('attendance_headers.user_id', $user->id)
                            ->where('approvals.type', 'izin')
                            ->whereBetween('date', [$request->start_from, $request->end_at])
                            ->rightJoin('approvals','attendance_headers.id','approvals.attendance_id')
                            ->count();

                $setting = \DB::table('payslip_setting_headers')
                            ->where('payslip_setting_headers.company_id', auth()->user()->company_id)
                            ->where('payslip_setting_headers.user_id', $user->id)
                            ->join('payslip_setting_details', 'payslip_setting_headers.id', 'payslip_setting_details.payslip_id')
                            ->select('payslip_setting_details.*')
                            ->get();

                $payslipUser = \DB::table('payslip_users')
                    ->insertGetId([
                        'company_id' => auth()->user()->company_id,
                        'branch_id' => $user->branch_id,
                        'users_id' => $user->id,
                        'payslip_id' => $header,
                        'name' => $user->name,
                        'present' => $attend,
                        'absence' => $absence,
                        'sick' => $sick,
                        'leave' => $leave
                    ]);

                foreach($setting as $set)
                {
                    $count = 0;
                    switch($set->time_id)
                    {
                        case 1:
                            $count = $set->value * $set->quantity;
                            break;
                            
                        case 2:
                            $count = $set->value * 7 * $set->quantity;
                            break;
                                
                        case 3:
                            if($set->criteria_id == '1'){
                                $count = $set->value * $set->quantity * $attend;
                            }
                            elseif($set->criteria_id == '2'){
                                $count = $set->value * $set->quantity * $absence;
                            }
                            break;

                        default:
                            break;

                    }

                    \DB::table('payslip_details')
                        ->insert([
                            'company_id' => auth()->user()->company_id,
                            'branch_id' => $user->branch_id,
                            'user_id' => $user->id,
                            'payslip_user_id' => $payslipUser,
                            'name' => $set->name,
                            'type' => $set->type,
                            'time_id' => $set->time_id,
                            'val' => $set->value,
                            'value' => $count,
                            'quantity' => $set->quantity,
                            'created_at' => now(),
                            'updated_at' => now()
                        ]);
                }
            }
        }

        return response()->json([
            'message' => 'Payslip created successfully'
        ], 201);
    }

    public function listPayslip($id)
    {
        $users = \DB::table('payslip_users')
            ->where('company_id', auth()->user()->company_id)
            ->where('payslip_id', $id)
            ->get();

        return response()->json($users, 200);
    }

    public function detailsPayslip($id)
    {
        $detail = \DB::table('payslip_details')
            ->where('company_id', auth()->user()->company_id)
            ->where('payslip_details.payslip_user_id', $id)
            ->get();
            
        $user = \DB::table('payslip_users')
            ->where('company_id', auth()->user()->company_id)
            ->where('id', $id)
            ->first();

        $total = 0;
        foreach($detail as $d)
        {
            if($d->type === '1'){
                $total += $d->value;
            }
            else{
                $total -= $d->value;
            }
        }
        
        return response()->json([
            'total' => $total,
            'details' => $detail,
            'user' => $user
        ], 200);
    }
}
