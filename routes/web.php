<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('login/index');
})->name('login');

Route::get('search/list', function () {
    return view('contacts/search-list', ['list_type' => 'search']);
})->name('search.list');

Route::get('lists/list', function () {
    return view('contacts/lists-list', ['list_type' => 'lists']);
})->name('lists.list');

Route::get('form/list', function () {
    return view('contacts/form-list');
})->name('form.list');
