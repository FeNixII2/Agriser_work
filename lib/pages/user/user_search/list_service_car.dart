import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

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
import '../user_search.dart';

class List_service_car extends StatefulWidget {
  const List_service_car({Key? key}) : super(key: key);

  @override
  State<List_service_car> createState() => _List_service_carState();
}

class _List_service_carState extends State<List_service_car> {
  List search_service = [];

  List dataProvince = [];
  List dataAmphure = [];
  var selectProvince;
  var selectAmphure;
  late String function, phone_provider, phone_user;
  List<int> allprices = [];
  double sum = 0;
  int c = 0;

  @override
  void initState() {
    super.initState();

    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      function = preferences.getString('function')!;
      phone_user = preferences.getString('phone_user')!;
      print("------------ Provider - Mode ------------");

      print("--- Get function State :     " + function);
      print("--- Get phone_user State :     " + phone_user);
    });
    Loadservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        title:
            Text("ข้อมูลการให้บริการ", style: GoogleFonts.mitr(fontSize: 18)),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          rate(),
          Data_Provider(),
        ],
      ),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_by_user.php?isAdd=true&function=$function&phone_user=$phone_user");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      checksum();
      return search_service;
    }
  }

  Widget Data_Provider() => Container(
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: search_service.length,
              itemBuilder: (context, index) {
                Uint8List imgfromb64 =
                    base64Decode(search_service[index]['image1']);

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          "id_service", search_service[index]["id_service"]);
                      preferences.setString("phone_provider",
                          search_service[index]["phone_provider"]);
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Data_service_car());
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
                                        Text("บริการเกี่ยวกับ: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 18)),
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
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['prices']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.green.shade400)),
                                        Text(" บาทต่อไร่",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("ยี่ห้อ: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['brand']}",
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
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['model']}",
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
        ),
      );

  rate() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ค่าเฉี่ยราคาต่อไร่อยู่ที่  ",
              style: GoogleFonts.mitr(
                fontSize: 16,
              )),
          Text("$c", style: GoogleFonts.mitr(fontSize: 25, color: Colors.red)),
          Text("  บาท",
              style: GoogleFonts.mitr(
                fontSize: 16,
              ))
        ],
      ),
    );
  }

  checksum() {
    int a;

    for (var i = 0; i < search_service.length; i++) {
      a = int.parse(search_service[i]['prices']);
      allprices.add(a);
    }

    for (var i = 0; i < allprices.length; i++) {
      sum += allprices[i];
    }

    setState(() {
      sum = sum / allprices.length;
      c = sum.toInt();
    });

    print("Sum : $sum");
  }
}
