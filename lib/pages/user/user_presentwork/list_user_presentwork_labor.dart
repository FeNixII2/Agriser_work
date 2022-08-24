import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/provider_service/type_provider_service_car.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_presentwork/edit_presentwork_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/select_presentwork_type.dart';
import 'package:agriser_work/pages/user/user_presentwork/type_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/type_user_presentwork_labor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class List_user_presentwork_labor extends StatefulWidget {
  const List_user_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<List_user_presentwork_labor> createState() =>
      _List_user_presentwork_laborState();
}

class _List_user_presentwork_laborState
    extends State<List_user_presentwork_labor> {
  List search_service = [];

  late String name_provider;
  late String phone_user;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_user = preferences.getString('phone_user')!;
      print("------------ Provider - Mode ------------");

      print("--- Get phone provider State :     " + phone_user);
    });
    Loadservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Select_presentwork_type()),
          ),
        ),
        title: Text("ข้อมูลประกาศจ้างงาน",
            style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
        // centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            Uint8List imgfromb64 =
                base64Decode(search_service[index]['img_field1']);
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString("id_presentwork",
                      search_service[index]['id_presentwork']);

                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => Edit_presentwork_labor());
                  Navigator.push(context, route);
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
                                    Text("ต้องการจ้าง: ",
                                        style: GoogleFonts.mitr(fontSize: 18)),
                                    Text(
                                        "${search_service[index]['type_presentwork']}",
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
                                    Text(" บาท",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("จำนวน: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['count_field']}",
                                        style: GoogleFonts.mitr(
                                            fontSize: 16,
                                            color: Colors.green.shade400)),
                                    Text(" ไร่",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("วันที่นัดหมาย: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['date_work']}",
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
          backgroundColor: Colors.green.shade400,
          child: Icon(Icons.edit),
          onPressed: () {
            print("คลิกเพิ่มรายการ");
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Type_user_presentwork_labor());
            Navigator.push(context, route);
          }),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_presentwork_labor.php?isAdd=true&phone_user=$phone_user");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
