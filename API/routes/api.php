<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BajuController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//baju
Route::get('/bajus', [BajuController::class, 'index']);
Route::get('/bajus/{id}', [BajuController::class, 'show']);
Route::post('/bajus', [BajuController::class, 'simpan']);
Route::put('/bajus/{id}', [BajuController::class, 'update']);
Route::delete('/bajus/{id}', [BajuController::class, 'destroy']);

