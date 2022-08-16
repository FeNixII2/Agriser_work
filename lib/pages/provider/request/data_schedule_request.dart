import 'dart:convert';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/request/provider_both_request.dart';
import 'package:agriser_work/pages/user/user_search/confirm_work.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_schedule.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
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

class Data_schedule_request extends StatefulWidget {
  const Data_schedule_request({Key? key}) : super(key: key);

  @override
  State<Data_schedule_request> createState() => _Data_schedule_requestState();
}

class _Data_schedule_requestState extends State<Data_schedule_request> {
  TextEditingController dateinput = TextEditingController();
  late String id_schedule,
      id_service,
      phone_user,
      count_field,
      total_price,
      date_work,
      map_lat_work,
      map_long_work,
      status,
      text_status,
      action;
  late String c_type,
      c_brand,
      c_model,
      c_datebuy,
      c_prices,
      c_image_car,
      c_image_license_plate;

  late String u_phone,
      u_name,
      u_email,
      u_date,
      u_sex,
      u_address,
      u_province,
      u_district,
      u_map_lat,
      u_map_long;

  late double lat = 0, long = 0;
  late String count_file, prices = "";
  late String formattedDate = "";
  late bool _isButtonDisabled_1;
  late bool _isButtonDisabled_2;

  @override
  void initState() {
    super.initState();

    findData();
    // findLocation();
  }

  void _incrementCounter_1() {
    if (status == "0") {
      change_status_1();
      dialong(context, "กำลังดำเนินงาน");
    }
    if (status == "1") {
      change_status_5();
      dialong(context, "รอคอนเฟิร์มเสร็จสิ้นงาน");
    }
  }

  void _incrementCounter_2() {
    if (status == "0") {
      change_status_3();
      dialong(context, "ยกเลิกงาน");
    }
    if (status == "1") {
      change_status_4();
      dialong(context, "รอคอนเฟิร์มยกเลิกงาน");
    }
    if (status == "4") {
      change_status_1();
      dialong(context, "กำลังดำเนินงาน");
    }
    if (status == "5") {
      change_status_1();
      dialong(context, "กำลังดำเนินงาน");
    }
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_schedule = preferences.getString('id_schedule')!;
      id_service = preferences.getString('id_service')!;
      phone_user = preferences.getString('phone_user')!;
      status = preferences.getString('status')!;
      action = preferences.getString('action')!;

      if (status == "0") {
        text_status = "รอการตอบรับงาน";
        _isButtonDisabled_1 = false;
        _isButtonDisabled_2 = false;
      }
      if (status == "1") {
        text_status = "อยู่ระหว่างดำเนินงาน";
        _isButtonDisabled_1 = false;
        _isButtonDisabled_2 = false;
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
        _isButtonDisabled_1 = true;
        _isButtonDisabled_2 = false;
      }
    });
    LoadData_service();
    LoadData_provider();
    tb_schedule_service_car();
  }

  Future LoadData_service() async {
    var url =
        "http://192.168.1.4/agriser_work/getServiceWhereIdservice.php?isAdd=true&id_service=$id_service";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        ModelService_Pro_car datauser = ModelService_Pro_car.fromJson(map);
        setState(() {
          c_type = datauser.type;
          c_brand = datauser.brand;
          c_model = datauser.model;
          c_datebuy = datauser.date_buy;
          c_prices = datauser.prices;
          c_image_car = datauser.image_car;
          c_image_license_plate = datauser.image_license_plate;

          prices = c_prices;

          // print("------------ Getinfo DataService ------------");
          // print("--- Get id_service State :     " + id_service);
          // print("--- Get c_type State :     " + c_type);
          // print("--- Get c_brand State :     " + c_brand);
          // print("--- Get c_model State :     " + c_model);
          // print("--- Get c_datebuy State :     " + c_datebuy);
          // print("--- Get c_prices State :     " + c_prices);
          // print("--- Get c_image_car State :     " + c_image_car);
          // print("--- Get c_image_license_plate State :     " +
          //     c_image_license_plate);
        });
      }
    }
  }

  Future LoadData_provider() async {
    var url =
        "http://192.168.1.4/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modeluser datauser = Modeluser.fromJson(map);
        setState(() {
          u_phone = datauser.phone;
          u_name = datauser.name;
          u_email = datauser.email;
          u_date = datauser.date;
          u_sex = datauser.sex;
          u_address = datauser.address;
          u_province = datauser.province;
          u_map_lat = datauser.map_lat;
          u_map_long = datauser.map_long;

          print("------------ Getinfo DataProvider ------------");
          print("--- Get p_phone State :     " + u_phone);
          print("--- Get p_name State :     " + u_name);
          print("--- Get p_email State :     " + u_email);
          print("--- Get p_date State :     " + u_date);
          print("--- Get p_sex State :     " + u_sex);
          print("--- Get p_address State :     " + u_address);
          print("--- Get p_address State :     " + u_province);
          print("--- Get p_map_lat State :     " + u_map_lat);
          print("--- Get p_map_long State :     " + u_map_long);
        });
      }
    }
  }

  Future tb_schedule_service_car() async {
    print("get tb_schedule_service_car");
    var url =
        "http://192.168.1.4/agriser_work/get_schedule_service_car.php?isAdd=true&id_schedule=$id_schedule";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Model_schedule datauser = Model_schedule.fromJson(map);
        setState(() {
          id_service = datauser.id_service;
          phone_user = datauser.phone_provider;
          count_field = datauser.count_field;
          total_price = datauser.total_price;
          date_work = datauser.date_work;
          map_lat_work = datauser.map_lat_work;
          map_long_work = datauser.map_long_work;

          lat = double.parse(map_lat_work);
          long = double.parse(map_long_work);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                  "http://192.168.1.4/agriser_work/upload_image/${c_image_car}"),
            ),
            Row(
              children: [
                Text("ต้องการว่าจ้าง   :  "),
                Allmethod().Space(),
                Text("$c_type"),
              ],
            ),
            Row(
              children: [
                Text("ชื่อ  :  "),
                Allmethod().Space(),
                Text("$u_name"),
              ],
            ),
            Row(
              children: [
                Text("เบอร์โทร  :  "),
                Allmethod().Space(),
                Text("$u_phone"),
              ],
            ),
            Row(
              children: [
                Text("อีเมลล์  :  "),
                Allmethod().Space(),
                Text("$u_email"),
              ],
            ),
            Row(
              children: [
                Text("ที่อยู่  :  "),
                Allmethod().Space(),
                Text("$u_address"),
              ],
            ),
            Row(
              children: [
                Text("อำเภอ  :  "),
                Allmethod().Space(),
                // Text("$c_type"),
              ],
            ),
            Row(
              children: [
                Text("จังหวัด  :  "),
                Allmethod().Space(),
                // Text("$c_type"),
              ],
            ),
            Row(
              children: [
                Text("ราคาจ่ายรวม  :  "),
                Allmethod().Space(),
                Text("$total_price"),
              ],
            ),
            Row(
              children: [
                Text("จำนวนไร่ที่จ้าง  :  "),
                Allmethod().Space(),
                Text("$count_field")
              ],
            ),
            Row(
              children: [
                Text("วันที่นัดหมาย  :  "),
                Allmethod().Space(),
                Text("$date_work")
              ],
            ),
            Text("จุดนัดพบ"),
            Container(
              child: FutureBuilder(builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (lat != 0) {
                  return showmap();
                }
                return Center(child: CircularProgressIndicator());
              }),
            ),
            Text("สถานะ : $text_status", style: GoogleFonts.mitr(fontSize: 22)),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text("ยืนยัน"),
                  onPressed: _isButtonDisabled_1 ? null : _incrementCounter_1,
                ),
                RaisedButton(
                  child: Text("ยกเลิก"),
                  onPressed: _isButtonDisabled_2 ? null : _incrementCounter_2,
                ),
              ],
            ),
          ],
        ),
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
      icon: BitmapDescriptor.defaultMarkerWithHue(120),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  Widget Countfield() => Container(
        width: 100.0,
        child: TextField(
          onChanged: (value) => count_file = value.trim(),
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Colors.black),
            labelText: "จำนวน",
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        ),
      );

  Widget Dateform() => Container(
        padding: EdgeInsets.all(15),
        height: 100,
        width: 200,
        child: TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: InputDecoration(
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "เลือกวันที่เริ่มงาน" //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            var dateTime = DateTime.now();
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(
                    1950), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.utc(dateTime.year, dateTime.month + 1,
                    dateTime.day, dateTime.hour, dateTime.minute));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                dateinput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      );

  Widget Button_next() => Container(
        width: 350,
        height: 50,
        child: RaisedButton(
            child: Text("ไปหน้าถัดไป"),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("count_field", count_file);
              preferences.setString("date_work", formattedDate);
              preferences.setString("prices", prices);

              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => Confirm_work());
              Navigator.push(context, route);
            }),
      );

  /////////////////////// CHANGE STATUS /////////////////////////////

  void change_status_5() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status.php?isAdd=true&status=5&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_4() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status.php?isAdd=true&status=4&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_3() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status.php?isAdd=true&status=3&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_2() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status.php?isAdd=true&status=2&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }

  void change_status_1() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/change_status.php?isAdd=true&status=1&id_schedule=$id_schedule");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    } else {}
  }
  /////////////////////// END CHANGE STATUS /////////////////////////////
}
