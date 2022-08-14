import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class provider_record_request extends StatefulWidget {
  const provider_record_request({Key? key}) : super(key: key);

  @override
  State<provider_record_request> createState() =>
      _provider_record_requestState();
}

class _provider_record_requestState extends State<provider_record_request> {
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
