import 'dart:convert';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/provider_service/type_provider_service_car.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_presentwork/type_user_presentwork.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class List_user_presentwork extends StatefulWidget {
  const List_user_presentwork({Key? key}) : super(key: key);

  @override
  State<List_user_presentwork> createState() => _List_user_presentworkState();
}

class _List_user_presentworkState extends State<List_user_presentwork> {
  List search_service = [];

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
      print("------------ Provider - Mode ------------");

      print("--- Get phone provider State :     " + phone_provider);
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
        backgroundColor: Colors.green.shade400,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const All_bottombar_user()),
          ),
        ),
        title: Text("ข้อมูลประกาศจ้างงาน"),
        // centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Container(
                  child: Image.network(
                      width: 100,
                      height: 100,
                      "http://192.168.1.4/agriser_work/upload_image/${search_service[index]['image_car']}"),
                ),
                title: Text(search_service[index]["brand"]),
                subtitle: Text(search_service[index]["prices"]),
                trailing: RaisedButton(
                  onPressed: () {},
                  child: Text("แก้ไข"),
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
                builder: (context) => Type_user_presentwork());
            Navigator.push(context, route);
          }),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_service.php?isAdd=true&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
