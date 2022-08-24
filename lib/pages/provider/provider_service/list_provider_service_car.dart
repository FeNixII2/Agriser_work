import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/provider_service/select_provider_type.dart';
import 'package:agriser_work/pages/provider/provider_service/type_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/type_provider_service_labor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class List_provider_service_car extends StatefulWidget {
  const List_provider_service_car({Key? key}) : super(key: key);

  @override
  State<List_provider_service_car> createState() =>
      _List_provider_service_carState();
}

class _List_provider_service_carState extends State<List_provider_service_car> {
  List search_service = [];
  late String select_type_service;
  late String name_provider;
  late String phone_provider;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_provider = preferences.getString('phone_user')!;
      select_type_service = preferences.getString("select_type_service")!;
      print("------------ Provider - Mode ------------");

      print("--- Get phone provider State :     " + phone_provider);
      print("--- Get select_type_service State :     " + select_type_service);
    });
    Loadservice();
  }

  Future getinfo_service() async {
    var url = "http://192.168.1.4/agriser_work/get_img.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Select_provider_type()),
          ),
        ),
        title: Text(
          "ข้อมูลการให้บริการ",
          style: GoogleFonts.mitr(fontSize: 18),
        ),
        // centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            Uint8List imgfromb64 =
                base64Decode(search_service[index]['image1']);
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  // SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // preferences.setString("id_presentwork",
                  //     search_service[index]['id_presentwork']);

                  // MaterialPageRoute route = MaterialPageRoute(
                  //     builder: (context) => Edit_presentwork_car());
                  // Navigator.push(context, route);
                },
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: MemoryImage(imgfromb64),
                            )),
                      ],
                    ),
                    Container(
                      // color: Colors.amber,

                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text("บริการ: ",
                                        style: GoogleFonts.mitr(fontSize: 18)),
                                    Text("${search_service[index]['type']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 18,
                                            color: Colors.green.shade400)),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("ราคา: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text("${search_service[index]['prices']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 16,
                                            color: Colors.green.shade400)),
                                    Text(" ต่อไร่",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("ยี่ห้อ: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text("${search_service[index]['brand']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 16,
                                            color: Colors.green.shade400)),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("รุ่น: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text("${search_service[index]['model']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 16,
                                            color: Colors.green.shade400)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit),
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Type_provider_service_car());
            Navigator.push(context, route);
          }),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_service_car.php?isAdd=true&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
