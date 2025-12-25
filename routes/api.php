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
    Route::get('/employees/all', [App\Http\Controllers\EmployeeController::class, 'all']);
    Route::post('/employees', [App\Http\Controllers\EmployeeController::class, 'store']);
    Route::get('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'show']);
    Route::get('/employees/{id}/edit', [App\Http\Controllers\EmployeeController::class, 'edit']);
    Route::put('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'update']);
    Route::delete('/employees/{id}', [App\Http\Controllers\EmployeeController::class, 'destroy']);

    Route::get('/schedules', [App\Http\Controllers\ScheduleController::class, 'index']);
    Route::post('/schedules', [App\Http\Controllers\ScheduleController::class, 'store']);

    // api user
    Route::get('/attendance/getschedule', [App\Http\Controllers\AttendanceController::class, 'index']);
    Route::post('/attendance/clockin', [App\Http\Controllers\AttendanceController::class, 'clockIn']);
    Route::post('/attendance/clockout', [App\Http\Controllers\AttendanceController::class, 'clockOut']);
    Route::get('/attendance/daily', [App\Http\Controllers\AttendanceController::class, 'getAttendance']);
});