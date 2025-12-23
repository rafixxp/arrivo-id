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
});