import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onlineshoe/Category/baju.dart';
import 'package:onlineshoe/inputdata/Baju/formInput.dart';

import 'inputdata/Baju/editData.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          title: Text('Product Page',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(Icons.notifications),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                // ignore: missing_return
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 2),
                        hintText: "Search ",
                        prefixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: () {}),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                      height: 40,
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormInput())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Masukan Produk",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      'New Product',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
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
                                  return ProdukBaju(x, index, context);
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
        ));
  }

  Container ProdukBaju(AsyncSnapshot x, int index, BuildContext context) {
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
                    width: 150,
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
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      "Rp. " + x.data['data'][index]['harga'].toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 12),
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
                                    builder: (context) => EditData(
                                        input: x.data['data'][index])));
                          },
                          child: Icon(Icons.edit),
                        ),
                        InkWell(
                          onTap: () {
                            deleteData(x.data['data'][index]['id'].toString())
                                .then((value) {
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Data sudah berhasil di hapus")));
                              });
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
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

class Categori extends StatelessWidget {
  final String image_location;
  final String image_caption;
  String alamat;
  Categori({this.image_location, this.image_caption, this.alamat});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                image_location,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
              width: 120,
              height: 60,
              child: Text(
                image_caption,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
