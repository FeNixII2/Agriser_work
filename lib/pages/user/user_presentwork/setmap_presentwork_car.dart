import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
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

class Setmap_presentwork_car extends StatefulWidget {
  const Setmap_presentwork_car({Key? key}) : super(key: key);

  @override
  State<Setmap_presentwork_car> createState() => _Setmap_presentwork_carState();
}

class _Setmap_presentwork_carState extends State<Setmap_presentwork_car> {
  late double map_lat_work, map_long_work;
  String load = "0";

  late String type, count, prices, date_work, details;
  late String img1;
  late String img2;

  late String phone_user;
  late String map_lat_user;
  late String map_long_user;
  TextEditingController dateinput = TextEditingController();
  late String formattedDate = "";
  @override
  void initState() {
    super.initState();
    findData();
    findLocation();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_user = preferences.getString('phone_user')!;
      type = preferences.getString('choose_type_service')!;
      count = preferences.getString('count')!;
      prices = preferences.getString('prices')!;
      date_work = preferences.getString('date_work')!;
      details = preferences.getString('details')!;
      if (details == "") {
        details = "ไม่มี";
      }

      img1 = preferences.getString('img1')!;
      img2 = preferences.getString('img2')!;

      print("----------------GETALLDATA---------------------");
      print(phone_user);
      print(type);
      print(count);
      print(prices);
      print(date_work);
      print(details);
      print(img1);
      print(img2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text(
          "เลือกจุดนัดพบ",
          style: GoogleFonts.mitr(
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: FutureBuilder(builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (load != "0") {
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
            onPressed: () {
              Alertconfirm();
            },
            child: Text(
              "ยืนยัน",
              style: GoogleFonts.mitr(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  void Alertconfirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ประกาศงาน', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการประกาศงานนี้ใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        upload_presentwork_car();
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

  ////////////////////////////////////   MAP  //////////////////////////////////////////////////////////////

  Future<Null> findLocation() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      map_lat_work = locationData!.latitude!;
      map_long_work = locationData.longitude!;
      load = map_lat_work.toString();
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
      height: 610,
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
      markerId: MarkerId("mylocation"),
      position: LatLng(map_lat_work, map_long_work),
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  Future upload_presentwork_car() async {
    final uri =
        Uri.parse("http://192.168.1.4/agriser_work/add_presentwork_car.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_user"] = phone_user;
    request.fields["type"] = type;
    request.fields["count"] = count;
    request.fields["prices"] = prices;
    request.fields["date_work"] = date_work;
    request.fields["details"] = details;
    request.fields["map_lat_work"] = map_lat_work.toString();
    request.fields["map_long_work"] = map_long_work.toString();
    request.fields["img1"] = img1;
    request.fields["img2"] = img2;

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => List_user_presentwork_car());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      print("UPLOAD");
      dialong(context, "ประกาศงานสำเร็จ");
    } else {
      print("UPLOAD FAIL");
    }
  }
}
