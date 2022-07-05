import 'dart:convert';

import 'package:agriser_work/pages/provider/provider_service/type_provider_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class List_provider_service extends StatefulWidget {
  const List_provider_service({Key? key}) : super(key: key);

  @override
  State<List_provider_service> createState() => _List_provider_serviceState();
}

class _List_provider_serviceState extends State<List_provider_service> {
  List search_service = [];
  late String id_provider = '512';

  @override
  void initState() {
    super.initState();
    Loadservice();
    // print("---------------search_service---------------");
    // print(search_service);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: search_service.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(search_service[index]["type"]),
              title: Text(search_service[index]["brand"]),
              subtitle: Text(search_service[index]["prices"]),
              trailing: RaisedButton(
                onPressed: () {},
                child: Text("แก้ไข"),
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
        "http://192.168.1.3/agriser_work/search_service.php?isAdd=true&id_provider=$id_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }
}
