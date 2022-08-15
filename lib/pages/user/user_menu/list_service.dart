import 'dart:convert';

import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utility/allmethod.dart';
import '../../provider/all_bottombar_provider.dart';
// import '../../provider/provider_service/type_provider_service.dart';
import '../user_search.dart';
import 'data_list_service.dart';

class List_service extends StatefulWidget {
  const List_service({Key? key}) : super(key: key);

  @override
  State<List_service> createState() => _List_serviceState();
}

class _List_serviceState extends State<List_service> {
  List search_service = [];

  List dataProvince = [];
  List dataAmphure = [];
  var selectProvince;
  var selectAmphure;
  late String lat_provider = "", long_provider = "";
  late String function;
  int result = 0;

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
      print("------------ Provider - Mode ------------");

      print("--- Get phone provider State :     " + function);
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
      body: Column(
        children: [
          Select_Province_and_Aumphures(),
          Data_Provider(),
        ],
      ),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_by_user.php?isAdd=true&function=$function");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }

  void all_data(id_service) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id_service", id_service);
    preferences.setString("lat_provider", lat_provider);
    preferences.setString("long_provider", long_provider);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => Data_list_service());
    Navigator.push(context, route);
    print(id_service);
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

  Widget Data_Provider() => Container(
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: search_service.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Container(
                      child: Image.network(
                          "http://192.168.1.4/agriser_work/upload_image/${search_service[index]['image_car']}"),
                    ),
                    title: Text(search_service[index]["brand"]),
                    subtitle: Text('ราคาต่อไร่ ' +
                        search_service[index]["prices"] +
                        ' บาท'),
                    trailing: RaisedButton(
                      onPressed: () {
                        lat_provider = search_service[index]["map_lat_provider"]
                            .toString();
                        long_provider = search_service[index]
                                ["map_long_provider"]
                            .toString();

                        all_data(search_service[index]["id_service"]);
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
