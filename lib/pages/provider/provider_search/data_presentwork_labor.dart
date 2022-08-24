import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/user/user_search/confirm_service_car.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_presentwork_labor.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:agriser_work/utility/model_service_provider_labor.dart';
import 'package:agriser_work/utility/modelprovider.dart';
import 'package:agriser_work/utility/modeluser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Data_presentwork_labor extends StatefulWidget {
  const Data_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Data_presentwork_labor> createState() => _Data_presentwork_laborState();
}

class _Data_presentwork_laborState extends State<Data_presentwork_labor> {
  TextEditingController dateinput = TextEditingController();
  late String id_presentwork, phone_user, function, checktype, phone_provider;
  late String type_presentwork,
      count_field,
      prices,
      info_choice,
      date_work,
      details,
      img_field1,
      img_field2,
      map_long_work,
      map_lat_work,
      choice,
      total_choice;

  late String p_phone,
      p_name,
      p_email,
      p_date,
      p_sex,
      p_address,
      p_province,
      p_district,
      p_map_lat,
      p_map_long;

  late double lat = 0, long = 0;
  late Uint8List imgfromb64;
  late String formattedDate = "", load = "0";

  @override
  void initState() {
    super.initState();
    findData();
    // findLocation();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_presentwork = preferences.getString('id_presentwork')!;
      phone_user = preferences.getString('phone_user')!;
      function = preferences.getString('function')!;
      phone_provider = preferences.getString('phone_provider')!;

      print("------------ Data - Mode ------------");
      print("--- Get id_service State :     " + id_presentwork);
      print("--- Get phone_provider State :     " + phone_provider);
    });
    LoadData_service();
  }

  Future LoadData_service() async {
    var url =
        "http://192.168.1.4/agriser_work/get_presentwork_labor.php?isAdd=true&id_presentwork=$id_presentwork";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modelpresentwork_labor datauser = Modelpresentwork_labor.fromJson(map);
        setState(() {
          type_presentwork = datauser.type_presentwork;
          count_field = datauser.count_field;
          prices = datauser.prices;
          info_choice = datauser.info_choice;
          date_work = datauser.date_work;
          details = datauser.details;
          img_field1 = datauser.img_field1;
          img_field2 = datauser.img_field2;
          map_long_work = datauser.map_long_work;
          map_lat_work = datauser.map_lat_work;
          choice = datauser.choice;
          total_choice = datauser.total_choice;

          imgfromb64 = base64Decode(img_field1);

          lat = double.parse(map_lat_work);
          long = double.parse(map_long_work);

          LoadData_user();
        });
      }
    }
  }

  Future LoadData_user() async {
    var url =
        "http://192.168.1.4/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modeluser datauser = Modeluser.fromJson(map);
        setState(() {
          p_phone = datauser.phone;
          p_name = datauser.name;
          p_email = datauser.email;
          p_date = datauser.date;
          p_sex = datauser.sex;
          p_address = datauser.address;
          p_province = datauser.province;
          p_district = datauser.district;
          p_map_lat = datauser.map_lat;
          p_map_long = datauser.map_long;

          print("------------ Getinfo DataProvider ------------");
          print("--- Get p_phone State :     " + p_phone);
          print("--- Get p_name State :     " + p_name);
          print("--- Get p_email State :     " + p_email);
          print("--- Get p_date State :     " + p_date);
          print("--- Get p_sex State :     " + p_sex);
          print("--- Get p_address State :     " + p_address);
          print("--- Get p_province State :     " + p_province);
          print("--- Get p_district State :     " + p_district);
          print("--- Get p_map_lat State :     " + p_map_lat);
          print("--- Get p_map_long State :     " + p_map_long);

          Loadampure();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลเกี่ยวกับงานประกาศแรงงานทางการเกษตร",
            style: GoogleFonts.mitr(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (load != "0") {
            return load_data();
          }
          return Center(child: CircularProgressIndicator());
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Colors.blue,
            onPressed: () async {
              check_idpresentwork_haved();
            },
            child: Text("ยืนยัน",
                style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Future check_idpresentwork_haved() async {
    var url =
        "http://192.168.1.4/agriser_work/check_schedule_presentwork.php?isAdd=true&id_presentwork=$id_presentwork&phone_provider=$phone_provider";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body == "false") {
        print("ไม่มีข้อมูลในระบบ");
        addschedule_presentwork();
      } else {
        dialong(context, "คุณได้ติดต่องานประกาศนี้ไปแล้ว");
        print("มีข้อมูลในระบบแล้ว");
      }
    }
  }

  ////////////////////////////////////   MAP  //////////////////////////////////////////////////////////////

  Container showmap() {
    LatLng latLng = LatLng(lat, long);
    CameraPosition Location_user = CameraPosition(target: latLng, zoom: 17);

    return Container(
      height: 300,
      // width: 300,
      child: GoogleMap(
        initialCameraPosition: Location_user,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: marker(),
      ),
    );
  }

  Marker mylocation() {
    return Marker(
      markerId: MarkerId("asdsadasdasd"),
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  Widget load_data() => Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Image.memory(
                imgfromb64,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("- รายละเอียดงาน -",
                      style: GoogleFonts.mitr(fontSize: 18)),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("งานประกาศ   :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$type_presentwork",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("เกี่ยวกับ   :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$total_choice",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("เพิ่มเติม   :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$info_choice",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("ราคาจ่าย :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$prices",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("จำนวนไร่  :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$count_field",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("วันที่ต้องการนัดหมาย  :  ",
                      style: GoogleFonts.mitr(fontSize: 16)),
                ),
                Allmethod().Space(),
                Text("$date_work",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("รายละเอียดเพิ่มเติม  :  ",
                      style: GoogleFonts.mitr(fontSize: 16)),
                ),
                Allmethod().Space(),
                Text("$details",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("- ข้อมูลติดต่อ -",
                      style: GoogleFonts.mitr(fontSize: 18)),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("ชื่อ  :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$p_name",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("เบอร์โทร  :  ",
                      style: GoogleFonts.mitr(fontSize: 16)),
                ),
                Allmethod().Space(),
                Text("$p_phone",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("อีเมลล์  :  ",
                      style: GoogleFonts.mitr(fontSize: 16)),
                ),
                Allmethod().Space(),
                Text("$p_email",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("ที่อยู่  :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$p_address",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("อำเภอ  :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$p_district",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Text("จังหวัด  :  ",
                        style: GoogleFonts.mitr(fontSize: 16))),
                Allmethod().Space(),
                Text("$p_province",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (lat != "0") {
                  return showmap();
                }
                return Center(child: CircularProgressIndicator());
              }),
            ),
          ],
        ),
      );

  Loadampure() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/showamphure.php?isAdd=true&id_district=$p_district");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        p_district = search_service[0]["name_th"];
        Loadprovince();
      });
    }
  }

  Loadprovince() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/showprovince.php?isAdd=true&id_province=$p_province");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        p_province = search_service[0]["name_th"];

        load = "1";
      });
    }
  }

  Future addschedule_presentwork() async {
    if (function == "5" || function == "6") {
      checktype = "labor";
    } else {
      checktype = "car";
    }
    print("id_presentwork:  $id_presentwork");
    print("type_presentwork:  $checktype");
    print("phone_user:  $phone_user");
    print("phone_provider:  $phone_provider");

    final uri = Uri.parse(
        "http://192.168.1.4/agriser_work/add_schedule_presentwork.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["id_presentwork"] = id_presentwork;
    request.fields["type_presentwork"] = checktype;
    request.fields["phone_user"] = phone_user;
    request.fields["phone_provider"] = phone_provider;

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      print("สำเร็จ");
    } else {
      print("ไม่สำเร็จ");
    }
  }
}
