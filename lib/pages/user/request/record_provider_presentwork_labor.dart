import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_search/confirm_service_car.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_presentwork_labor.dart';
import 'package:agriser_work/utility/model_schedule.dart';
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

class Record_provider_presentwork_labor extends StatefulWidget {
  const Record_provider_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Record_provider_presentwork_labor> createState() =>
      _Record_provider_presentwork_laborState();
}

class _Record_provider_presentwork_laborState
    extends State<Record_provider_presentwork_labor> {
  late String id_schedule, status, action;

  late String id_presentwork,
      phone_user,
      type_presentwork,
      count_field,
      prices,
      date_work,
      details,
      img_field1,
      img_field2,
      map_lat_work,
      map_long_work,
      status_work;

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
  late bool _isButtonDisabled_1;
  late bool _isButtonDisabled_2;
  late String load = "0";
  late String phone_provider;
  late String text_status, check_carlabor;
  late Uint8List imgfromb64;
  @override
  void initState() {
    super.initState();
    print("-----------------ShowDATA++++++++++++++++++++");
    findData();
  }

  clearpremission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("id_schedule");
    preferences.remove("id_service");
    preferences.remove("phone_user");
    preferences.remove("status");
    preferences.remove("action");
  }

  void _incrementCounter_1() {
    if (status == "0") {
      change_status_service_1();
      dialong(context, "กำลังดำเนินงาน");
    }
    if (status == "4") {
      change_status_service_3();
      dialong(context, "รอคอนเฟิร์มยกเลิกงาน");
    }
    if (status == "5") {
      change_status_service_2();
      dialong(context, "รอคอนเฟิร์มเสร็จสิ้นงาน");
    }
  }

  void _incrementCounter_2() {
    if (status == "0") {
      change_status_service_3();
      dialong(context, "ยกเลิกงาน");
    }
    if (status == "1") {
      change_status_service_4();
      dialong(context, "รอคอนเฟิร์มยกเลิกงาน");
    }
    if (status == "4") {
      change_status_service_1();
      dialong(context, "กำลังดำเนินงาน");
    }
    if (status == "5") {
      change_status_service_1();
      dialong(context, "กำลังดำเนินงาน");
    }
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_schedule = preferences.getString('id_schedule')!;
      id_presentwork = preferences.getString('id_presentwork')!;
      phone_provider = preferences.getString('phone_provider')!;
      phone_user = preferences.getString('phone_user')!;
      status = preferences.getString('status')!;
      action = preferences.getString('action')!;
      check_carlabor = preferences.getString('check_carlabor')!;

      print("------------ Data - Mode ------------");
      print("--- Get status State :     " + id_schedule);
      print("--- Get status State :     " + id_presentwork);
      print("--- Get status State :     " + phone_provider);
      print("--- Get status State :     " + status);
      print("--- Get status State :     " + action);
      print("--- Get status State :     " + check_carlabor);

      if (status == "0") {
        text_status = "รอการตอบรับงาน";
        _isButtonDisabled_1 = false;
        _isButtonDisabled_2 = false;
      }
      if (status == "1") {
        text_status = "อยู่ระหว่างดำเนินงาน";
        _isButtonDisabled_1 = true;
        _isButtonDisabled_2 = true;
      }
      if (status == "2") {
        text_status = "เสร็จสิ้นงาน";
        _isButtonDisabled_1 = true;
        _isButtonDisabled_2 = true;
      }
      if (status == "3") {
        text_status = "ยกเลิกงาน";
        _isButtonDisabled_1 = true;
        _isButtonDisabled_2 = true;
      }
      if (status == "4") {
        text_status = "รอคอนเฟิร์มยกเลิกงาน";
        _isButtonDisabled_1 = false;
        _isButtonDisabled_2 = false;
      }
      if (status == "5") {
        text_status = "รอคอนเฟิร์มเสร็จสิ้นงาน";
        _isButtonDisabled_1 = false;
        _isButtonDisabled_2 = false;
      }

      LoadData_presentwork_labor();
      LoadData_provider();
    });
  }

  Future LoadData_presentwork_labor() async {
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
          date_work = datauser.date_work;
          details = datauser.details;
          img_field1 = datauser.img_field1;
          img_field2 = datauser.img_field2;
          map_lat_work = datauser.map_lat_work;
          map_long_work = datauser.map_long_work;

          imgfromb64 = base64Decode(img_field1);
          lat = double.parse(map_lat_work);
          long = double.parse(map_long_work);

          Loadampure();
        });
      }
    }
  }

  Future LoadData_provider() async {
    var url =
        "http://192.168.1.4/agriser_work/getProviderWhereProvider.php?isAdd=true&phone_provider=$phone_provider";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modelprovider datauser = Modelprovider.fromJson(map);
        setState(() {
          p_phone = datauser.phone;
          p_name = datauser.name;
          p_email = datauser.email;
          p_date = datauser.date;
          p_sex = datauser.sex;
          p_address = datauser.address;
          p_district = datauser.district;
          p_province = datauser.province;
          p_map_lat = datauser.map_lat;
          p_map_long = datauser.map_long;

          print("------------ Getinfo DataProvider ------------");
          print("--- Get p_phone State :     " + p_phone);
          print("--- Get p_name State :     " + p_name);
          print("--- Get p_email State :     " + p_email);
          print("--- Get p_date State :     " + p_date);
          print("--- Get p_sex State :     " + p_sex);
          print("--- Get p_address State :     " + p_address);
          print("--- Get p_address State :     " + p_province);
          print("--- Get p_map_lat State :     " + p_map_lat);
          print("--- Get p_map_long State :     " + p_map_long);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("รายละเอียด", style: GoogleFonts.mitr(fontSize: 18)),
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
    );
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
        mapType: MapType.hybrid,
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

  load_data() {
    return service_labor();
  }

  /////////////////////////  change status  ///////////////////////////////////////

  void change_status_service_5() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status_presentwork.php?isAdd=true&status=5&id_schedule=$id_schedule&id_presentwork=$id_presentwork&check_carlabor=$check_carlabor");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_service_4() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status_presentwork.php?isAdd=true&status=4&id_schedule=$id_schedule&id_presentwork=$id_presentwork&check_carlabor=$check_carlabor");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_service_3() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status_presentwork.php?isAdd=true&status=3&id_schedule=$id_schedule&id_presentwork=$id_presentwork&check_carlabor=$check_carlabor");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_service_2() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status_presentwork.php?isAdd=true&status=2&id_schedule=$id_schedule&id_presentwork=$id_presentwork&check_carlabor=$check_carlabor");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_service_1() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status_presentwork.php?isAdd=true&status=1&id_schedule=$id_schedule&id_presentwork=$id_presentwork&check_carlabor=$check_carlabor");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  ///////////////////////// end   change status  ///////////////////////////////////////

  Widget service_labor() => Container(
        child: Column(children: [
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
                Text("- ข้อมูลติดต่อ -", style: GoogleFonts.mitr(fontSize: 18)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child:
                      Text("ชื่อ  :  ", style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$p_name",
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
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
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
            ],
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                child:
                    Text("อีเมลล์  :  ", style: GoogleFonts.mitr(fontSize: 16)),
              ),
              Allmethod().Space(),
              Text("$p_email",
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
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
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
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
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
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
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 43, 65, 234))),
            ],
          ),
          Text("จุดนัดพบ", style: GoogleFonts.mitr(fontSize: 18)),
          Container(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (lat != 0) {
                return showmap();
              }
              return Center(child: CircularProgressIndicator());
            }),
          ),
          Text("สถานะ : $text_status", style: GoogleFonts.mitr(fontSize: 22)),
        ]),
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
}
