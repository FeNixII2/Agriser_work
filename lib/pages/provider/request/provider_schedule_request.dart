import 'dart:convert';
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
  late String status = "", type = "";

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
                        leading: Text(search_service[index]["id_service"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        title: Text(search_service[index]["type_service"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        trailing: Text("$status",
                            style: GoogleFonts.mitr(fontSize: 18)),
                        subtitle: Text(search_service[index]["phone_user"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                      ),
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
        "http://192.168.1.4/agriser_work/search_schedule_service_car_urp.php?isAdd=true&phone_provider=$phone_provider");
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
