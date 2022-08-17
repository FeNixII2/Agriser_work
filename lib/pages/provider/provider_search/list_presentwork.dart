import 'dart:convert';

import 'package:agriser_work/pages/provider/provider_search/data_presentwork_car.dart';
import 'package:agriser_work/pages/provider/provider_search/data_presentwork_labor.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_search/data_service_car.dart';
import 'package:agriser_work/pages/user/user_search/data_service_labor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utility/allmethod.dart';
import '../../provider/all_bottombar_provider.dart';
// import '../../provider/provider_service/type_provider_service.dart';

class List_presentwork extends StatefulWidget {
  const List_presentwork({Key? key}) : super(key: key);

  @override
  State<List_presentwork> createState() => _List_presentworkState();
}

class _List_presentworkState extends State<List_presentwork> {
  List search_service = [];

  List dataProvince = [];
  List dataAmphure = [];
  var selectProvince;
  var selectAmphure;
  late String function, phone_provider, phone_user;
  int result = 0;
  late String fix_img;

  @override
  void initState() {
    super.initState();
    getAllprovince();
    findUser();
  }

  Future getAllprovince() async {
    // print("เข้าแล้วเน้อ");

    var url = "http://192.168.1.4/Agriser_work/getProvince.php?isAdd=true";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dataProvince = jsonData;
        // data = jsonData;
      });
      // print(dataProvince);
      // return dataProvince;
    }
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      function = preferences.getString('function')!;
      phone_provider = preferences.getString('phone_provider')!;
      print("------------ Provider - Mode ------------");

      print("--- Get function State :     " + function);
      print("--- Get phone_user State :     " + phone_provider);
    });
    Loadservice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลงานประกาศ"),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Select_Province_and_Aumphures(),
          Data_user(),
        ],
      ),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_by_Provider.php?isAdd=true&function=$function&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }

  void all_data(id_presentwork) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id_presentwork", id_presentwork);
    preferences.setString("phone_user", phone_user);
    if (function == "5" || function == "6") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Data_presentwork_labor());
      Navigator.push(context, route);
    } else {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Data_presentwork_car());
      Navigator.push(context, route);
    }
  }

  Widget Select_Province_and_Aumphures() => Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      hint: Text("เลือกจังหวัด"),
                      value: selectProvince,
                      items: dataProvince.map((provinces) {
                        return DropdownMenuItem(
                            value: provinces['id'],
                            child: Text(provinces['name_th']));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectProvince = value;
                          // print(selectProvince);
                          getSelectAmphures();
                        });
                      }),
                ],
              ),
              Column(
                children: [
                  DropdownButton(
                      hint: Text("เลือกอำเภอ"),
                      value: selectAmphure,
                      items: dataAmphure.map((amphures) {
                        return DropdownMenuItem(
                            value: amphures['id'],
                            child: Text(amphures['name_th']));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectAmphure = value;
                          // print(selectAmphure);
                        });
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: RaisedButton(
                  onPressed: () =>
                      search_provider_province(selectProvince, selectAmphure),
                  child: Icon(
                    Icons.beach_access,
                    color: Colors.blue,
                    size: 16.0,
                  ),
                ),
              ),
            ]),
      );

  void search_provider_province(province, amphures) async {
    var dio = Dio();

    if (province == null || amphures == null) {
      print('1');
      final response = await dio.get(
          "http://192.168.1.4/agriser_work/search_by_user.php?isAdd=true&function=$function");
      if (response.statusCode == 200) {
        setState(() {
          search_service = json.decode(response.data);
        });
        print('หาตามอำเภอ');
        print(search_service);
      }
    } else {
      print(selectProvince);
      print(selectAmphure);
      final response = await dio.get(
          "http://192.168.1.4/agriser_work/search_by_user_provinces.php?isAdd=true&function=$function&province=$selectProvince&amphures=$selectAmphure");
      if (response.statusCode == 200) {
        setState(() {
          search_service = json.decode(response.data);
        });
        print('หาตามอำเภอ');
        print(search_service);
      }
    }
  }

  Widget Data_user() => Container(
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: search_service.length,
              itemBuilder: (context, index) {
                if (function == "5" || function == "6") {
                  fix_img = search_service[index]['img_field1'];
                } else {
                  fix_img = search_service[index]['img_field1'];
                }
                return Card(
                  child: ListTile(
                    leading: Container(
                      child: Image.network(
                          "http://192.168.1.4/agriser_work/upload_image/${fix_img}"),
                    ),
                    title: Text(search_service[index]["type_presentwork"]),
                    subtitle: Text(
                        'ราคาจ่าย ' + search_service[index]["prices"] + ' บาท'),
                    trailing: RaisedButton(
                      onPressed: () {
                        phone_user =
                            search_service[index]["phone_user"].toString();

                        all_data(search_service[index]["id_presentwork"]);
                      },
                      child: Text("ดูข้อมูล"),
                    ),
                  ),
                );
              }),
        ),
      );

  Future getSelectAmphures() async {
    // print("มาอำเภอ");
    var url =
        "http://192.168.1.4/Agriser_work/getSelectAmphures.php?isAdd=true&&idprovince=$selectProvince";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dataAmphure = jsonData;
        // data = jsonData;
      });

      // print(dataAmphure);
      // return dataAmphure;
    }
  }
}
