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
import '../../../utility/dialog.dart';
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
  List<int> allprices = [];
  double sum = 0;
  int c = 0;

  late String price = "";
  // List lat_user = [];
  // List long_user = [];
  var select_Province;
  var select_Amphure;

  @override
  void initState() {
    super.initState();
    getAllprovince();
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
          Row(
            children: [
              Container(
                // color: Colors.green.shade100,
                width: 320,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      provincE(),
                      districT(),
                    ],
                  ),
                ),
              ),
              Container(
                // color: Colors.amber.shade200,
                width: 50,
                height: 50,
                child: RaisedButton(
                  onPressed: () {
                    if (select_Province == null && select_Amphure == null) {
                      if (price == "") {
                        Loadservice();
                      } else {
                        print("price: " + price);
                        Loadservice_sortprice();
                      }
                    } else if (select_Amphure == null) {
                      if (price == "") {
                        Loadserviceprovince();
                      } else {
                        print("price: " + price);
                        Loadserviceprovince_sortprice();
                      }
                    } else {
                      if (price == "") {
                        check_address_provider();
                      } else {
                        check_address_provider2();
                      }
                    }
                  },
                  child: Icon(
                    Icons.search,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          rate(),
          Data_Provider(),
        ],
      ),
    );
  }

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/search_by_user.php?isAdd=true&function=$function&phone_user=$phone_user");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      checksum();
      return search_service;
    }
  }

  Loadservice_sortprice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/search_by_user_sortprice.php?isAdd=true&function=$function&phone_user=$phone_user&price=$price");
    if (response.statusCode == 200) {
      if (response.data == "null") {
        dialong(context, "ไม่มีราคานี้");
      } else {
        setState(() {
          search_service = json.decode(response.data);
        });
        // print(search_service);
        // loadalllatlonguser();

        return search_service;
      }
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
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: MemoryImage(imgfromb64),
                                )),
                          ],
                        ),
                        Container(
                          // color: Colors.amber,

                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("บริการเกี่ยวกับ: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 18)),
                                        Text("${search_service[index]['type']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 18,
                                                color: Colors.green.shade400)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("ราคา: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['prices']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.green.shade400)),
                                        Text(" บาทต่อวัน",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("ประเภท: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                          "${search_service[index]['total_choice']}",
                                          style: GoogleFonts.mitr(
                                              fontSize: 16,
                                              color: Colors.green.shade400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("ข้อมูลเพิ่มเติม: ",
                                            style:
                                                GoogleFonts.mitr(fontSize: 16)),
                                        Text(
                                            "${search_service[index]['info_choice']}",
                                            style: GoogleFonts.mitr(
                                                fontSize: 16,
                                                color: Colors.green.shade400)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );

  rate() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("ค่าเฉี่ยต่อวันอยู่ที่  ",
              style: GoogleFonts.mitr(
                fontSize: 16,
              )),
          Text("$c", style: GoogleFonts.mitr(fontSize: 25, color: Colors.red)),
          Text("  บาท ",
              style: GoogleFonts.mitr(
                fontSize: 16,
              )),
          Sort_price(),
          Text(" ค้นหา", style: GoogleFonts.mitr(fontSize: 18)),
        ],
      ),
    );
  }

  checksum() {
    int a;

    for (var i = 0; i < search_service.length; i++) {
      a = int.parse(search_service[i]['prices']);
      allprices.add(a);
    }

    for (var i = 0; i < allprices.length; i++) {
      sum += allprices[i];
    }

    setState(() {
      sum = sum / allprices.length;
      c = sum.toInt();
    });

    print("Sum : $sum");
  }

  Future getAllprovince() async {
    // print("เข้าแล้วเน้อ");

    var url = "http://103.212.181.47/agriser_work/getProvince.php?isAdd=true";

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

  Future getSelectAmphures() async {
    // print("มาอำเภอ");
    var url =
        "http://103.212.181.47/agriser_work/getSelectAmphures.php?isAdd=true&&idprovince=$select_Province";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print("+++++++++++++++>     $jsonData");
      setState(() {
        dataAmphure = jsonData;

        // data = jsonData;
      });

      // print(dataAmphure);
      // return dataAmphure;
    }
  }

  Widget provincE() => Container(
        width: 300,
        child: DropdownButton(
            hint: Text("เลือกจังหวัด", style: GoogleFonts.mitr(fontSize: 18)),
            value: select_Province,
            items: dataProvince.map((provinces) {
              return DropdownMenuItem(
                  value: provinces['id'],
                  child: Text(provinces['name_th'],
                      style: GoogleFonts.mitr(fontSize: 18)));
            }).toList(),
            onChanged: (value) {
              if (select_Amphure == null) {
                setState(() {
                  select_Province = value.toString();
                  // print(select_Province);
                });
              } else {
                select_Amphure = null;
                setState(() {
                  select_Province = value.toString();
                  // print(select_Province);
                });
              }

              getSelectAmphures();
            }),
      );

  Widget Sort_price() => Container(
        height: 60,
        width: 100,
        child: TextField(
          keyboardType: TextInputType.number,
          style: GoogleFonts.mitr(fontSize: 18),
          onChanged: (value) => price = value.trim(),
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Colors.black),
            hintText: "ราคา", hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget districT() => Container(
        width: 300,
        child: DropdownButton(
            hint: Text("เลือกอำเภอ", style: GoogleFonts.mitr(fontSize: 18)),
            value: select_Amphure,
            items: dataAmphure.map((amphures) {
              return DropdownMenuItem(
                  value: amphures['id'],
                  child: Text(amphures['name_th'],
                      style: GoogleFonts.mitr(fontSize: 18)));
            }).toList(),
            onChanged: (value) {
              setState(() {
                select_Amphure = value.toString();
                print(select_Amphure);
              });
            }),
      );

  check_address_provider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/getprovider_search.php?isAdd=true&phone_provider=$phone_user&province_provider=$select_Province&district_provider=$select_Amphure&function=$function");
    if (response.statusCode == 200) {
      if (response.data == "null") {
        dialong(context, "ไม่มีข้อมูล");
      } else {
        setState(() {
          search_service = json.decode(response.data);
        });
        print(search_service);

        // get_allservice();
        return search_service;
      }
    }
  }

  check_address_provider2() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/getprovider_search2.php?isAdd=true&phone_provider=$phone_user&province_provider=$select_Province&district_provider=$select_Amphure&function=$function&price=$price");
    if (response.statusCode == 200) {
      if (response.data == "null") {
        dialong(context, "ไม่มีข้อมูล");
      } else {
        setState(() {
          search_service = json.decode(response.data);
        });
        print(search_service);

        // get_allservice();
        return search_service;
      }
    }
  }

  Loadserviceprovince() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/getserviceprovince.php?isAdd=true&phone_provider=$phone_user&province_provider=$select_Province&function=$function");
    if (response.statusCode == 200) {
      if (response.data == "null") {
        dialong(context, "ไม่มีข้อมูล");
      } else {
        setState(() {
          search_service = json.decode(response.data);
        });
        print(search_service);

        // get_allservice();
        return search_service;
      }
    }
  }

  Loadserviceprovince_sortprice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/getserviceprovince_sortprice.php?isAdd=true&phone_provider=$phone_user&province_provider=$select_Province&function=$function&price=$price");
    if (response.statusCode == 200) {
      if (response.data == "null") {
        dialong(context, "ไม่มีข้อมูล");
      } else {
        setState(() {
          search_service = json.decode(response.data);
        });
        print(search_service);

        // get_allservice();
        return search_service;
      }
    }
  }
}
