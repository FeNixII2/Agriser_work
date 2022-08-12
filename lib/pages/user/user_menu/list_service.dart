import 'dart:convert';

import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../provider/all_bottombar_provider.dart';
import '../../provider/provider_service/type_provider_service.dart';
import '../user_search.dart';

class List_service extends StatefulWidget {
  const List_service({Key? key}) : super(key: key);

  @override
  State<List_service> createState() => _List_serviceState();
}

class _List_serviceState extends State<List_service> {
  List search_service = [];

  late String function;
  int result = 0;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      function = preferences.getString('function')!;
      print("------------ Provider - Mode ------------");

      print("--- Get phone provider State :     " + function);
    });
    Loadservice();
  }

  Future getinfo_service() async {
    var url = "http://192.168.88.213/agriser_work/get_img.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const All_bottombar_user()),
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
                leading: Container(
                  child: Image.network(
                      "http://192.168.88.213/agriser_work/upload_image/${search_service[index]['image_car']}"),
                ),
                title: Text(search_service[index]["brand"]),
                subtitle: Text(
                    'ราคาต่อไร่ ' + search_service[index]["prices"] + ' บาท'),
                trailing: RaisedButton(
                  onPressed: () =>
                      all_data(search_service[index]["id_service"]),
                  child: Text("ดูข้อมูล"),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.edit),
          onPressed: () {
            print("คลิกเพิ่มรายการ");
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Type_provider_service());
            Navigator.push(context, route);
          }),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.88.213/agriser_work/search_by_user.php?isAdd=true&function=$function");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }

  void all_data(id_service) {
    setState(() {
      print(id_service);
    });
  }
}
