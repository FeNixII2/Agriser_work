import 'dart:convert';
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

class List_service_labor extends StatefulWidget {
  const List_service_labor({Key? key}) : super(key: key);

  @override
  State<List_service_labor> createState() => _List_service_laborState();
}

class _List_service_laborState extends State<List_service_labor> {
  List search_service = [];

  List dataProvince = [];
  List dataAmphure = [];
  var selectProvince;
  var selectAmphure;
  late String function, phone_provider, phone_user;

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
                  child: Container(
                    height: 100,
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString(
                            "id_service", search_service[index]["id_service"]);
                        preferences.setString("phone_provider",
                            search_service[index]["phone_provider"]);
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Data_service_labor());
                        Navigator.push(context, route);
                      },
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 80,
                              child: Image.memory(
                                imgfromb64,
                              ),
                            ),
                            title: Text(search_service[index]["type"],
                                style: GoogleFonts.mitr(fontSize: 18)),
                            trailing: Text(search_service[index]["prices"],
                                style: GoogleFonts.mitr(fontSize: 18)),
                            subtitle: Text(
                                search_service[index]["total_choice"],
                                style: GoogleFonts.mitr(fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
}
