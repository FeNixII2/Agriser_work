import 'dart:convert';
import 'dart:typed_data';
import 'package:agriser_work/pages/provider/request/data_schedule_request_car.dart';
import 'package:agriser_work/pages/provider/request/data_schedule_request_labor.dart';
import 'package:agriser_work/pages/user/contact/data_schedule_contact_car.dart';
import 'package:agriser_work/pages/user/contact/data_schedule_contact_labor.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider_schedule_request extends StatefulWidget {
  const Provider_schedule_request({Key? key}) : super(key: key);

  @override
  State<Provider_schedule_request> createState() =>
      _Provider_schedule_requestState();
}

class _Provider_schedule_requestState extends State<Provider_schedule_request> {
  List search_service = [];

  late String phone_provider, id_service;
  late String status = "", type = "", show = "";

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_provider = preferences.getString('phone_provider')!;
      print("------------ Provider - Mode ------------");
      print("--- Get phone provider State :     " + phone_provider);
    });
    Loadservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            Uint8List imgfromb64 =
                base64Decode(search_service[index]['show_img']);
            if (search_service[index]["status"] == "0") {
              status = "รอการตอบรับ";
            }
            if (search_service[index]["status"] == "1") {
              status = "ดำเนินการ";
            }
            if (search_service[index]["status"] == "4") {
              status = "รอคอนเฟิร์มยกเลิก";
            }
            if (search_service[index]["status"] == "5") {
              status = "รอคอนเฟิร์มเสร็จ";
            }
            if (search_service[index]["type_service"] == "car") {
              show = "รถเกษตร";
            }
            if (search_service[index]["type_service"] == "labor") {
              show = "แรงงานเกษตร";
            }

            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString(
                      "id_schedule", search_service[index]["id_schedule"]);
                  preferences.setString(
                      "id_service", search_service[index]["id_service"]);
                  preferences.setString(
                      "phone_user", search_service[index]["phone_user"]);

                  preferences.setString(
                      "status", search_service[index]["status"]);

                  preferences.setString(
                      "action", search_service[index]["action"]);

                  if (search_service[index]["type_service"] == "car") {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Data_schedule_request_car());
                    Navigator.push(context, route);
                  } else if (search_service[index]["type_service"] == "labor") {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Data_schedule_request_labor());
                    Navigator.push(context, route);
                  }
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
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Text("งานประกาศ: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_type']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("ชื่อ: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_servicename']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("จังหวัด: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_province']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("นัดหมาย: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['date_work']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$status",
                        style: GoogleFonts.mitr(
                            fontSize: 18, color: Colors.green.shade400),
                      ),
                    )
                  ],
                ),
              ),
            );
            return Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString(
                      "id_schedule", search_service[index]["id_schedule"]);
                  preferences.setString(
                      "id_service", search_service[index]["id_service"]);
                  preferences.setString(
                      "phone_user", search_service[index]["phone_user"]);

                  preferences.setString(
                      "status", search_service[index]["status"]);

                  preferences.setString(
                      "action", search_service[index]["action"]);

                  if (search_service[index]["type_service"] == "car") {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Data_schedule_request_car());
                    Navigator.push(context, route);
                  } else if (search_service[index]["type_service"] == "labor") {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Data_schedule_request_labor());
                    Navigator.push(context, route);
                  }
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
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_type']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("ชื่อ: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_servicename']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("จังหวัด: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['show_province']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text("นัดหมาย: ",
                                        style: GoogleFonts.mitr(fontSize: 16)),
                                    Text(
                                        "${search_service[index]['date_work']}",
                                        style: GoogleFonts.mitr(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "$status",
                        style: GoogleFonts.mitr(
                            fontSize: 18, color: Colors.green.shade400),
                      ),
                    )
                  ],
                ),
              ),
            );

            return Card(
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 100,
                child: InkWell(
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.setString(
                        "id_schedule", search_service[index]["id_schedule"]);
                    preferences.setString(
                        "id_service", search_service[index]["id_service"]);
                    preferences.setString(
                        "phone_user", search_service[index]["phone_user"]);

                    preferences.setString(
                        "status", search_service[index]["status"]);

                    preferences.setString(
                        "action", search_service[index]["action"]);

                    if (search_service[index]["type_service"] == "car") {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Data_schedule_request_car());
                      Navigator.push(context, route);
                    } else if (search_service[index]["type_service"] ==
                        "labor") {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Data_schedule_request_labor());
                      Navigator.push(context, route);
                    }
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading:
                            Text(show, style: GoogleFonts.mitr(fontSize: 18)),
                        title: Text(search_service[index]["id_schedule"],
                            style: GoogleFonts.mitr(fontSize: 16)),
                        trailing: Text("$status",
                            style: GoogleFonts.mitr(fontSize: 18)),
                        subtitle: Text(search_service[index]["id_service"],
                            style: GoogleFonts.mitr(fontSize: 16)),
                      ),
                      Text(
                          "เบอร์ผู้ติดต่อ: " +
                              search_service[index]["phone_user"],
                          style: GoogleFonts.mitr(fontSize: 16))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  // Card(
  //             child: ListTile(
  //               leading: const Icon(Icons.add),
  //               title: Text(search_service[index]["date_work"]),
  //               trailing: Text(search_service[index]["status"]),
  //               subtitle: Text(search_service[index]["total_price"]),
  //               selected: true,
  //               onTap: () {
  //                 print("object");
  //               },
  //             ),
  //           );

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/search_schedule_service_car_urp.php?isAdd=true&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);

      return search_service;
    }
  }

  loadtype() {}
}
