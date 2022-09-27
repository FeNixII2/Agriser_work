import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/contact/user_both_contact.dart';
import 'package:agriser_work/pages/user/user_search/confirm_service_car.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_schedule.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:agriser_work/utility/model_service_provider_labor.dart';
import 'package:agriser_work/utility/modelprovider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Record_schedule_contact_car extends StatefulWidget {
  const Record_schedule_contact_car({Key? key}) : super(key: key);

  @override
  State<Record_schedule_contact_car> createState() =>
      _Record_schedule_contact_carState();
}

class _Record_schedule_contact_carState
    extends State<Record_schedule_contact_car> {
  TextEditingController dateinput = TextEditingController();

  late String id_schedule,
      id_service,
      phone_provider,
      count_field,
      total_price,
      date_work,
      map_lat_work,
      map_long_work,
      status,
      action,
      text_status,
      check_carlabor;

  late String type, brand, model, date_buy, prices, image1, image2;

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
  late String formattedDate = "";
  late bool _isButtonDisabled_1;
  late bool _isButtonDisabled_2;
  late String load = "0", rating, comment;
  late Uint8List imgfromb64;

  @override
  void initState() {
    super.initState();
    print("-----------------ShowDATA++++++++++++++++++++");
    findData();
  }

  void push_rating() {
    final _dialog = RatingDialog(
      initialRating: 1,
      title: Text(
        'ให้คะแนน',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'เลือกให้คะแนนความพึงพอใจสำหรับผู้ให้บริการนี้',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      submitButtonText: 'ตกลง',
      commentHint: 'แสดงความคิดเห็นเพิ่มเติม',
      onSubmitted: (response) {
        String b = response.rating.toString();
        rating = b.split(".").first;
        comment = response.comment.toString();
        add_rating();
      },
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _dialog,
    );
  }

  void _incrementCounter_1() {
    if (status == "4") {
      change_status_service_3();
    }
    if (status == "5") {
      push_rating();
    }
  }

  void _incrementCounter_2() {
    if (status == "0") {
      change_status_service_3();
    }

    if (status == "4") {
      change_status_service_3();
    }
    if (status == "5") {
      change_status_service_2();
    }
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_schedule = preferences.getString('id_schedule')!;
      id_service = preferences.getString('id_service')!;
      phone_provider = preferences.getString('phone_provider')!;
      status = preferences.getString('status')!;
      action = preferences.getString('action')!;

      if (status == "0") {
        text_status = "รอการตอบรับงาน";
        _isButtonDisabled_1 = true;
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

      print("------------ Data - Mode ------------");

      print("--- Get status State :     " + action);

      tb_schedule_service();
    });
  }

  Future LoadData_service() async {
    var url =
        "http://103.212.181.47/agriser_work/get_service_car.php?isAdd=true&id_service=$id_service";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        ModelService_Pro_car datauser = ModelService_Pro_car.fromJson(map);
        setState(() {
          id_service = datauser.id_service;
          type = datauser.type;
          brand = datauser.brand;
          model = datauser.model;
          date_buy = datauser.date_buy;

          image1 = datauser.image1;
          image2 = datauser.image2;

          imgfromb64 = base64Decode(image1);

          LoadData_provider();
        });
      }
    }
  }

  Future LoadData_provider() async {
    var url =
        "http://103.212.181.47/agriser_work/getProviderWhereProvider.php?isAdd=true&phone_provider=$phone_provider";
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

          Loadampure();
        });
      }
    }
  }

  Future tb_schedule_service() async {
    var url =
        "http://103.212.181.47/agriser_work/get_schedule_service.php?isAdd=true&id_schedule=$id_schedule";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Model_schedule datauser = Model_schedule.fromJson(map);
        setState(() {
          id_service = datauser.id_service;
          type = datauser.type_service;
          phone_provider = datauser.phone_provider;
          count_field = datauser.count_field;
          total_price = datauser.total_price;
          date_work = datauser.date_work;
          map_lat_work = datauser.map_lat_work;
          map_long_work = datauser.map_long_work;

          lat = double.parse(map_lat_work);
          long = double.parse(map_long_work);

          LoadData_service();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดบริการ", style: GoogleFonts.mitr(fontSize: 16)),
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (load != "0") {
            return check_type();
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

  check_type() {
    return service_car();
  }

  /////////////////////////  change status  ///////////////////////////////////////

  void change_status_service_5() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/change_status_service.php?isAdd=true&status=5&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "รอคอนเฟิร์มงานสำเร็จ");
    } else {}
  }

  void change_status_service_4() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/change_status_service.php?isAdd=true&status=4&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "รอคอนเฟิร์มยกเลิกงาน");
    } else {}
  }

  void change_status_service_3() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/change_status_service.php?isAdd=true&status=3&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ยกเลิกงาน");
    } else {}
  }

  void change_status_service_2() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/change_status_service.php?isAdd=true&status=2&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "งานสำเร็จ");
    } else {}
  }

  void change_status_service_1() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/change_status_service.php?isAdd=true&status=1&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "กำลังดำเนินการ");
    } else {}
  }

  ///////////////////////// end   change status  ///////////////////////////////////////

  Widget service_car() => Container(
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
                Text("- รายละเอียดบริการ -",
                    style: GoogleFonts.mitr(fontSize: 18)),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("บริการเกี่ยวกับ   :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$type",
                  style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("ยี้ห้อรถ   :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$brand",
                  style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("รุ่นรถ   :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$model",
                  style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("ปีที่ซื้อรถ   :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$date_buy",
                  style: GoogleFonts.mitr(fontSize: 18, color: Colors.red)),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("ราคารวม :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("$total_price",
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("- ข้อมูลผู้ให้บริการ -",
                    style: GoogleFonts.mitr(fontSize: 18)),
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
          Text("- จุดนัดพบ -", style: GoogleFonts.mitr(fontSize: 18)),
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
        "http://103.212.181.47/agriser_work/showamphure.php?isAdd=true&id_district=$p_district");
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
        "http://103.212.181.47/agriser_work/showprovince.php?isAdd=true&id_province=$p_province");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        p_province = search_service[0]["name_th"];
        load = "1";
      });
    }
  }

  Future add_rating() async {
    final uri =
        Uri.parse("http://103.212.181.47/agriser_work/add_rating_comment.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["id_schedule"] = id_schedule;
    request.fields["phone_provider"] = phone_provider;
    request.fields["rating"] = rating;
    request.fields["comment"] = comment;

    var response = await request.send();

    if (response.statusCode == 200) {
      change_status_service_2();
      print("UPLOAD");
    } else {
      print("UPLOAD FAIL");
    }
  }
}
