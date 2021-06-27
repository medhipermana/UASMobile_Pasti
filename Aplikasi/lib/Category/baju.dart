import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:onlineshoe/inputdata/Baju/editData.dart';

class DetailScreenBaju extends StatefulWidget {
  const DetailScreenBaju({Key key}) : super(key: key);

  @override
  _DetailScreenBajuState createState() => _DetailScreenBajuState();
}

class _DetailScreenBajuState extends State<DetailScreenBaju> {
  final String url = "http://192.168.1.8:80/api/bajus";
  Future getInput() async {
    var response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  Future deleteData(String dataId) async {
    final String url = "http://192.168.1.8:80/api/bajus/" + dataId;
    var response = await http.delete(Uri.parse(url));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title:
            Text('Clothes', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                      future: getInput(),
                      builder: (context, x) {
                        if (x.hasData) {
                          return ListView.builder(
                              itemCount: x.data['data'].length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return produkBaju(x, index, context);
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container produkBaju(AsyncSnapshot x, int index, BuildContext context) {
    return Container(
      height: 160,
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Container(
              child: InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    x.data['data'][index]['gambar'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              child: Expanded(
                  child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      x.data['data'][index]['nama'],
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "Rp. " + x.data['data'][index]['harga'].toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditData(input: x.data['data'][index])));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Ubah",
                                style: GoogleFonts.poppins(color: Colors.blue, fontSize: 13)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteData(x.data['data'][index]['id'].toString()).then((value) {
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Data sudah berhasil di hapus")));
                              });
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 32),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("Hapus",
                                style: GoogleFonts.poppins(color: Colors.blue, fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Tandai stok habis",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                        ))
                  ],
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
