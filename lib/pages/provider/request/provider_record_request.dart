import 'dart:convert';
import 'package:agriser_work/pages/provider/request/data_schedule_request.dart';
import 'package:agriser_work/pages/user/contact/data_schedule_contact.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider_record_request extends StatefulWidget {
  const Provider_record_request({Key? key}) : super(key: key);

  @override
  State<Provider_record_request> createState() =>
      _Provider_record_requestState();
}

class _Provider_record_requestState extends State<Provider_record_request> {
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
                    preferences.setString(
                        "id_service", search_service[index]["id_service"]);
                    preferences.setString(
                        "phone_user", search_service[index]["phone_user"]);

                    preferences.setString(
                        "status", search_service[index]["status"]);

                    preferences.setString(
                        "action", search_service[index]["action"]);

                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Data_schedule_request());
                    Navigator.push(context, route);
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: Text(search_service[index]["id_schedule"]),
                        title: Text(search_service[index]["total_price"]),
                        trailing: Text("$status"),
                        subtitle: Text(search_service[index]["date_work"]),
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
        "http://192.168.1.4/agriser_work/search_record_schedule_service_car_urp.php?isAdd=true&phone_provider=$phone_provider");
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
