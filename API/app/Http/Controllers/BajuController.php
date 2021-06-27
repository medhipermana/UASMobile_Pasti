<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Baju;

class BajuController extends Controller
{
    public function index(){
        $bajus = Baju::all();
        return response()->json(['Message' => 'Data Baju','data' => $bajus]);
    }
    public function show($id)
    {
        $bajus = Baju::find($id);
        return response()->json(['Message' => 'Toko saya', 'data' => $bajus]);
    }

    //untuk formnya dibuat di postman dengan method POST nanti ditambahkan di body isi dari data API kita seperti nama, deskripsi,dll
    //setelah itu baru ke method Simpan ini, abis buat formnya diaplikasi nanti akan disimpan ke database dan muncul pesan sucess di postman
    public function simpan(Request $request)
    {
        $bajus = Baju::create($request->all());
        return  response()->json(['Message' => 'Berhasil disimpan', 'data' => $bajus]);
    }

    //method edit di API
    // method update perlu parameter id agar data yang di edit jelas di ID mana di edit 
    public function update(Request $request, $id)
    {
        $bajus = Baju::find($id);
        $bajus->update($request->all());
        return response()->json(['Message' => 'Berhasil diupdate', 'data' => $bajus]);
    }

    //method Delete di APi
    public function destroy($id)
    {
        $bajus = Baju::find($id);
        $bajus->delete();
        return response()->json(['Message' => 'Berhasil didelete', 'data' => null]);
    }
}
