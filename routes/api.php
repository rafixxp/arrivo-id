<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('/signin', [App\Http\Controllers\AuthController::class, 'signIn']);

Route::middleware(['auth:sanctum'])->group(function(){
    Route::post('/logout', [App\Http\Controllers\AuthController::class, 'logout']);

    // api super admin & admin
    Route::get('/company', [App\Http\Controllers\CompaniesController::class, 'index']);
    Route::post('/company', [App\Http\Controllers\CompaniesController::class, 'store']);

    Route::get('/branches', [App\Http\Controllers\BranchController::class, 'index']);
    Route::post('/branches', [App\Http\Controllers\BranchController::class, 'store']);
    Route::put('/branches/{id}', [App\Http\Controllers\BranchController::class, 'update']);
    Route::delete('/branches/{id}', [App\Http\Controllers\BranchController::class, 'destroy']);
    
    Route::get('/position', [App\Http\Controllers\PositionController::class, 'index']);
    Route::post('/position', [App\Http\Controllers\PositionController::class, 'store']);
    Route::put('/position/{id}', [App\Http\Controllers\PositionController::class, 'update']);
    Route::delete('/position/{id}', [App\Http\Controllers\PositionController::class, 'destroy']);
    
    Route::get('/hours', [App\Http\Controllers\HoursController::class, 'index']);
    Route::post('/hours', [App\Http\Controllers\HoursController::class, 'store']);
    Route::put('/hours/{id}', [App\Http\Controllers\HoursController::class, 'update']);
    Route::delete('/hours/{id}', [App\Http\Controllers\HoursController::class, 'destroy']);
    
    Route::get('/employees', [App\Http\Controllers\EmployeeController::class, 'index']);
    Route::get('/employees/hours/{id}', [App\Http\Controllers\EmployeeController::class, 'all']);
    Route::post('/employees', [App\Http\Controllers\EmployeeController::class, 'store']);
    Route::get('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'show']);
    Route::get('/employees/{id}/edit', [App\Http\Controllers\EmployeeController::class, 'edit']);
    Route::put('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'update']);
    Route::delete('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'destroy']);

    Route::get('/schedules', [App\Http\Controllers\ScheduleController::class, 'index']);
    Route::post('/schedules', [App\Http\Controllers\ScheduleController::class, 'store']);
    Route::post('/schedules/custom', [App\Http\Controllers\ScheduleController::class, 'addSchedule']);
    Route::post('/schedules/update', [App\Http\Controllers\ScheduleController::class, 'update']);
    Route::get('/attendance/daily', [App\Http\Controllers\AttendanceController::class, 'getAttendance']);
    Route::post('/attendance/daily', [App\Http\Controllers\AttendanceController::class, 'getAttendance']);
    Route::get('/attendance/detail/{id}', [App\Http\Controllers\AttendanceController::class, 'attendanceDetail']);

    Route::get('/leave', [App\Http\Controllers\ApprovalController::class, 'index']);
    Route::post('/leave', [App\Http\Controllers\ApprovalController::class, 'store']);
    Route::get('/leave/{id}', [App\Http\Controllers\ApprovalController::class, 'show']);
    Route::get('/approval/list', [App\Http\Controllers\ApprovalController::class, 'list']);
    Route::put('/approval/{id}', [App\Http\Controllers\ApprovalController::class, 'update']);

    Route::get('/payslip', [App\Http\Controllers\PayslipController::class, 'index']);
    Route::get('/payslip/times', [App\Http\Controllers\PayslipController::class, 'times']);
    Route::get('/payslip/component', [App\Http\Controllers\PayslipController::class, 'component']);
    Route::get('/payslip/component/criteria', [App\Http\Controllers\PayslipController::class, 'criteria']);
    Route::post('/payslip/component', [App\Http\Controllers\PayslipController::class, 'storeComponent']);
    Route::post('/payslip/component/generate', [App\Http\Controllers\PayslipController::class, 'generateComponent']);
    Route::get('/payslip/setting', [App\Http\Controllers\PayslipController::class, 'setting']);
    Route::get('/payslip/setting/{id}', [App\Http\Controllers\PayslipController::class, 'settingDetail']);
    Route::post('/payslip/setting/{id}', [App\Http\Controllers\PayslipController::class, 'editDetail']);
    Route::post('/payslip/generate', [App\Http\Controllers\PayslipController::class, 'generatePayslip']);
    Route::get('/payslip/lists/{id}', [App\Http\Controllers\PayslipController::class, 'listPayslip']);
    Route::get('/payslip/details/{id}', [App\Http\Controllers\PayslipController::class, 'detailsPayslip']);

    // api user
    Route::get('/attendance/getschedule', [App\Http\Controllers\AttendanceController::class, 'index']);
    Route::middleware('device-config')->post('/attendance/clockin', [App\Http\Controllers\AttendanceController::class, 'clockIn']);
    Route::middleware('device-config')->post('/attendance/clockout', [App\Http\Controllers\AttendanceController::class, 'clockOut']);
    Route::get('/attendance/schedules', [App\Http\Controllers\AttendanceController::class, 'getUserSchedule']);
    Route::get('/attendance/recap', [App\Http\Controllers\AttendanceController::class, 'attendanceRecap']);
});