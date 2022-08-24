import 'dart:convert';
import 'package:agriser_work/pages/user/request/record_provider_presentwork_car.dart';
import 'package:agriser_work/pages/user/request/record_provider_presentwork_labor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_record_request extends StatefulWidget {
  const User_record_request({Key? key}) : super(key: key);

  @override
  State<User_record_request> createState() => _User_record_requestState();
}

class _User_record_requestState extends State<User_record_request> {
  List search_service = [];

  late String name_provider;
  late String phone_user, status;

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
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            if (search_service[index]["status"] == "2") {
              status = "งานเสร็จสิ้น";
            }
            if (search_service[index]["status"] == "3") {
              status = "งานถูกยกเลิก";
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
                    preferences.setString("id_presentwork",
                        search_service[index]["id_presentwork"]);
                    preferences.setString("phone_provider",
                        search_service[index]["phone_provider"]);

                    preferences.setString(
                        "status", search_service[index]["status"]);

                    preferences.setString(
                        "action", search_service[index]["action"]);

                    preferences.setString("check_carlabor",
                        search_service[index]["type_presentwork"]);

                    if (search_service[index]["type_presentwork"] == "car") {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) =>
                              Record_provider_presentwork_car());
                      Navigator.push(context, route);
                    } else if (search_service[index]["type_presentwork"] ==
                        "labor") {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) =>
                              Record_provider_presentwork_labor());
                      Navigator.push(context, route);
                    }
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(search_service[index]["id_presentwork"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        title: Text(search_service[index]["type_presentwork"],
                            style: GoogleFonts.mitr(fontSize: 18)),
                        trailing: Text("$status",
                            style: GoogleFonts.mitr(fontSize: 18)),
                        subtitle: Text(search_service[index]["phone_provider"],
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

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_record_schedule_presentwork_pru.php?isAdd=true&phone_user=$phone_user");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
