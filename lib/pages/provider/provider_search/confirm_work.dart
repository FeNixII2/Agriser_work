import 'dart:convert';
import 'dart:ffi';

import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Confirm_presentwork extends StatefulWidget {
  const Confirm_presentwork({Key? key}) : super(key: key);

  @override
  State<Confirm_presentwork> createState() => _Confirm_presentworkState();
}

class _Confirm_presentworkState extends State<Confirm_presentwork> {
  late int total_price;
  late double map_lat_work = 0, map_long_work;
  late String date_work,
      phone_user,
      phone_provider,
      count_field,
      prices,
      id_service,
      function,
      type_service;
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
      prices = preferences.getString('prices')!;
      function = preferences.getString('function')!;
      total_price = int.parse(prices) * int.parse(count_field);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context)),
        title: Text("ยืนยันงาน"),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Text('งานเริ่มวันที่ $date_work'),
          Text('ราคาทั้งหมด $total_price บาท'),
          Container(
            child: FutureBuilder(builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (map_lat_work != 0) {
                return showmap();
              }
              return Center(child: CircularProgressIndicator());
            }),
          ),
          RaisedButton(
            onPressed: () {
              addschedule_user();
            },
            child: Text("ยืนยันรายการ"),
          ),
        ],
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
      height: 450,
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
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: marker(),
      ),
    );
  }

  Marker mylocation() {
    return Marker(
      markerId: MarkerId("asdsadasdasd"),
      position: LatLng(map_lat_work, map_long_work),
      icon: BitmapDescriptor.defaultMarkerWithHue(120),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  void addschedule_user() async {
    if (function == "5" || function == "6") {
      type_service = "labor";
    } else {
      type_service = "car";
    }

    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/add_schedule_service_car.php?isAdd=true&id_service=$id_service&phone_user=$phone_user&phone_provider=$phone_provider&date_work=$date_work&count_field=$count_field&total_price=$total_price&map_lat_work=$map_lat_work&map_long_work=$map_long_work&type_service=$type_service");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }
}
