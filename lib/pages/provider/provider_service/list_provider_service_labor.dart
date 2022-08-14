import 'dart:convert';

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

class List_provider_service_labor extends StatefulWidget {
  const List_provider_service_labor({Key? key}) : super(key: key);

  @override
  State<List_provider_service_labor> createState() =>
      _List_provider_service_laborState();
}

class _List_provider_service_laborState
    extends State<List_provider_service_labor> {
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
        title: Text("ข้อมูลการให้บริการ"),
        // centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                // leading: Container(
                //   height: 380,
                //   child: Image.network(
                //       width: 100,
                //       height: 100,
                //       "http://192.168.1.4/agriser_work/upload_image/${search_service[index]['image_car']}"),
                // ),
                title: Text(search_service[index]["type"]),
                subtitle: Text(search_service[index]["prices"]),
                trailing: RaisedButton(
                  onPressed: () {},
                  child: Text("แก้ไข"),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit),
          onPressed: () {
            if (select_type_service == "car") {
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Type_provider_service_car());
              Navigator.push(context, route);
            }
            if (select_type_service == "labor") {
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Type_provider_service_labor());
              Navigator.push(context, route);
            }
          }),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_service_labor.php?isAdd=true&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
