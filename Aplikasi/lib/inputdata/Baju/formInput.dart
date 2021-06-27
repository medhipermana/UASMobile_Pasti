import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class FormInput extends StatefulWidget {
  @override
  _FormInputState createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  TextEditingController ukuranController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController gambarController = TextEditingController();
  //membuat method POST untuk Upload data ke API
  Future saveUpload() async {
    // karena ingin menambahkan data/POST maka perlu tambahan body karena di body API kita akan menambahkan data object yang ditulis harus sama dengan yang ada di API
    final response = await http.post(Uri.parse("http://192.168.1.8:80/api/bajus"), body: {
      "nama": namaController.text,
      "warna": warnaController.text,
      "ukuran": ukuranController.text,
      "harga": hargaController.text,
      "deskripsi": desController.text,
      "gambar": gambarController.text,
    });
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: Text(
            "Tambah Produk",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          )),
      body: Form(
        key: _formkey,
        child: Container(
          margin: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Text("Foto produk"),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                          color: Colors.lightBlue.shade700,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              saveUpload().then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text(
                            "Ambil dari Galeri",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text("atau", style: GoogleFonts.poppins(color: Colors.grey.shade600)),
                    ),
                    SizedBox(
                        height: 35,
                        // ignore: deprecated_member_use
                        child: TextFormField(
                          controller: gambarController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 2),
                            hintText: "Ketik Image Url",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Nama Produk"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  maxLength: 100,
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Text("Harga Produk"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Text("Deskripsi"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  maxLines: 10,
                  controller: desController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Text("Ukuran"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: ukuranController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Text("Warna"),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: TextField(
                  controller: warnaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: RaisedButton(
                          color: Colors.white,
                          textColor: Colors.blue,
                          child: Text(
                            'Batal',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: RaisedButton(
                          splashColor: Colors.white,
                          color: Colors.blue[900],
                          textColor: Colors.white,
                          child: Text(
                            'Tambahkan',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 18),
                          ),
                          onPressed: () {
                            if (_formkey.currentState.validate()) {
                              saveUpload().then((value) {
                                Navigator.pop(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
