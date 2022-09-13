import 'dart:convert';
import 'dart:ffi';

import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../all_bottombar_user.dart';

class Confirm_service_car extends StatefulWidget {
  const Confirm_service_car({Key? key}) : super(key: key);

  @override
  State<Confirm_service_car> createState() => _Confirm_service_carState();
}

class _Confirm_service_carState extends State<Confirm_service_car> {
  late double map_lat_work = 0, map_long_work;
  late String date_work,
      phone_user,
      phone_provider,
      count_field,
      total_price,
      id_service,
      function,
      type_service;
  late String show_img,
      show_servicename,
      show_type,
      show_province,
      show_servicename_pro,
      show_province_pro;
  @override
  void initState() {
    super.initState();
    findData();
    findLocation();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_service = preferences.getString('id_service')!;
      date_work = preferences.getString('date_work')!;
      phone_user = preferences.getString('phone_user')!;
      phone_provider = preferences.getString('phone_provider')!;
      count_field = preferences.getString('count_field')!;
      total_price = preferences.getString('total_price')!;
      function = preferences.getString('function')!;
      show_img = preferences.getString('show_img')!;
      show_type = preferences.getString('show_type')!;
      show_servicename = preferences.getString('show_servicename')!;
      show_province = preferences.getString('show_province')!;
      show_servicename_pro = preferences.getString('show_servicename_pro')!;
      show_province_pro = preferences.getString('show_province_pro')!;

      print("AAAASD----------------AAAAAAAAAAAA------------------AAAAAAAAAA");
      print("$show_img");
      print("$show_type");
      print("$show_servicename");
      print("$show_province");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        title: Text("เลือกจุดนัดพบ", style: GoogleFonts.mitr(fontSize: 18)),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (map_lat_work != 0) {
                return showmap();
              }
              return Center(child: CircularProgressIndicator());
            }),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Colors.green.shade400,
            onPressed: () async {
              Alertconfirm();
            },
            child: Text("ยืนยัน",
                style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////   MAP  //////////////////////////////////////////////////////////////

  Future<Null> findLocation() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      map_lat_work = locationData!.latitude!;
      map_long_work = locationData.longitude!;
      print("lat = $map_lat_work , long = $map_long_work");
    });
  }

  Future<LocationData?> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Container showmap() {
    LatLng latLng = LatLng(map_lat_work, map_long_work);
    CameraPosition Location_user = CameraPosition(target: latLng, zoom: 17);

    return Container(
      height: 612,
      // width: 300,
      child: GoogleMap(
        onTap: (LatLng laalongg) {
          setState(() {
            map_lat_work = laalongg.latitude;
            map_long_work = laalongg.longitude;
            print("lat = $map_lat_work , long = $map_long_work");
          });
        },
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
      position: LatLng(map_lat_work, map_long_work),
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  Future addschedule_user() async {
    if (function == "5" || function == "6") {
      type_service = "labor";
    } else {
      type_service = "car";
    }

    final uri =
        Uri.parse("http://192.168.1.4/agriser_work/add_schedule_service.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["id_service"] = id_service;
    request.fields["phone_user"] = phone_user;
    request.fields["phone_provider"] = phone_provider;
    request.fields["date_work"] = date_work;
    request.fields["count_field"] = count_field;
    request.fields["total_price"] = total_price;
    request.fields["map_lat_work"] = map_lat_work.toString();
    request.fields["map_long_work"] = map_long_work.toString();
    request.fields["type_service"] = type_service;
    request.fields["show_img"] = show_img;
    request.fields["show_type"] = show_type;
    request.fields["show_servicename"] = show_servicename;
    request.fields["show_province"] = show_province;
    request.fields["show_servicename_pro"] = show_servicename_pro;
    request.fields["show_province_pro"] = show_province_pro;

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_user());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ติดต่อบริการสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  // void addschedule_user() async {
  //   if (function == "5" || function == "6") {
  //     type_service = "labor";
  //   } else {
  //     type_service = "car";
  //   }

  //   var dio = Dio();
  //   final response = await dio.get(
  //       "http://192.168.1.4/agriser_work/add_schedule_service.php?isAdd=true&id_service=$id_service&phone_user=$phone_user&phone_provider=$phone_provider&date_work=$date_work&count_field=$count_field&total_price=$total_price&map_lat_work=$map_lat_work&map_long_work=$map_long_work&type_service=$type_service&show_type=$show_type&show_servicename=$show_servicename&show_province=$show_province");

  //   print(response.data);
  //   if (response.data == "true") {
  //     MaterialPageRoute route =
  //         MaterialPageRoute(builder: (context) => All_bottombar_user());
  //     Navigator.pushAndRemoveUntil(context, route, (route) => false);
  //     dialong(context, "ติดต่อบริการสำเร็จ");
  //   } else {
  //     dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
  //   }
  // }

  void Alertconfirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ติดต่อว่าจ้าง', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการติดต่องานบริการนี้ใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        addschedule_user();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('ยกเลิก', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
