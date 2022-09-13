import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/provider/provider_search/data_presentwork_car.dart';
import 'package:agriser_work/pages/provider/provider_search/data_presentwork_labor.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_search/data_service_car.dart';
import 'package:agriser_work/pages/user/user_search/data_service_labor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utility/allmethod.dart';
import '../../provider/all_bottombar_provider.dart';
// import '../../provider/provider_service/type_provider_service.dart';

class List_presentwork extends StatefulWidget {
  const List_presentwork({Key? key}) : super(key: key);

  @override
  State<List_presentwork> createState() => _List_presentworkState();
}

class _List_presentworkState extends State<List_presentwork> {
  List search_service = [];

  List dataProvince = [];
  List dataAmphure = [];
  var selectProvince;
  var selectAmphure;
  late String function, phone_provider, phone_user;
  int result = 0;
  late String fix_img;

  @override
  void initState() {
    super.initState();

    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      function = preferences.getString('function')!;
      phone_provider = preferences.getString('phone_provider')!;
      print("------------ Provider - Mode ------------");

      print("--- Get function State :     " + function);
      print("--- Get phone_user State :     " + phone_provider);
    });
    Loadservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลงานประกาศ", style: GoogleFonts.mitr(fontSize: 18)),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          data_presentwork(),
        ],
      ),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_by_Provider.php?isAdd=true&function=$function&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }

  void all_data(id_presentwork) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id_presentwork", id_presentwork);
    preferences.setString("phone_user", phone_user);
    if (function == "5" || function == "6") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Data_presentwork_labor());
      Navigator.push(context, route);
    } else {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Data_presentwork_car());
      Navigator.push(context, route);
    }
  }

  Widget data_presentwork() => Container(
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: search_service.length,
              itemBuilder: (context, index) {
                Uint8List imgfromb64 =
                    base64Decode(search_service[index]['img_field1']);
                if (function == "5" || function == "6") {
                  fix_img = search_service[index]['img_field1'];
                } else {
                  fix_img = search_service[index]['img_field1'];
                }

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      phone_user =
                          search_service[index]["phone_user"].toString();

                      all_data(search_service[index]["id_presentwork"]);
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
                                        Text("ต้องการบริการ: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 18)),
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
                                        Text("ราคาจ้าง: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['prices']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.green.shade400)),
                                        Text(" บาท",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("วันที่นัดหมาย: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['date_work']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.green.shade400)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("จำนวนไร่: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['count_field']}",
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

                return Container(
                  height: 100,
                  child: InkWell(
                    child: Card(
                      color: Color.fromARGB(255, 201, 201, 201),
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          child: Image.memory(
                            imgfromb64,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(
                            "ประเภท:  " +
                                search_service[index]["type_presentwork"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        subtitle: Text(
                            "วันนัดหมาย:  " +
                                search_service[index]["date_work"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        trailing: Text(search_service[index]["prices"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                      ),
                    ),
                    onTap: () {
                      phone_user =
                          search_service[index]["phone_user"].toString();

                      all_data(search_service[index]["id_presentwork"]);
                    },
                  ),
                );
              }),
        ),
      );
}
