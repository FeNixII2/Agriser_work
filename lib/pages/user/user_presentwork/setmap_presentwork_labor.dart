import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_labor.dart';
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

class Setmap_presentwork_labor extends StatefulWidget {
  const Setmap_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Setmap_presentwork_labor> createState() =>
      _Setmap_presentwork_laborState();
}

class _Setmap_presentwork_laborState extends State<Setmap_presentwork_labor> {
  late double map_lat_work, map_long_work;
  String load = "0";

  late String type_presentwork,
      count_field,
      prices,
      info_choice,
      date_work,
      details,
      img1,
      img2,
      box1,
      box2,
      box3,
      box4,
      box5,
      box6,
      total_choice;

  late String phone_user;
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
      type_presentwork = preferences.getString('choose_type_service')!;
      count_field = preferences.getString('count_field')!;
      prices = preferences.getString('prices')!;
      info_choice = preferences.getString('info_choice')!;
      date_work = preferences.getString('date_work')!;
      details = preferences.getString('details')!;
      img1 = preferences.getString('img1')!;
      img2 = preferences.getString('img2')!;
      box1 = preferences.getString('box1')!;
      box2 = preferences.getString('box2')!;
      box3 = preferences.getString('box3')!;
      box4 = preferences.getString('box4')!;
      box5 = preferences.getString('box5')!;
      box6 = preferences.getString('box6')!;
      total_choice = preferences.getString('total_choice')!;
      if (details == "") {
        details = "ไม่มี";
      }
      if (info_choice == "") {
        info_choice = "ไม่มี";
      }

      print(phone_user);
      print(type_presentwork);
      print(count_field);
      print(prices);
      print(info_choice);
      print(date_work);
      print(details);

      print(img1);
      print(img2);
      print(box1);
      print(box2);
      print(box3);
      print(box4);
      print(box5);
      print(box6);
      print(total_choice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("เลือกจุดนัดพบ", style: GoogleFonts.mitr(fontSize: 18)),
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
            child: Text("ยืนยัน",
                style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
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
        upload_presentwork_labor();
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

  Future upload_presentwork_labor() async {
    print(phone_user);
    print(type_presentwork);
    print(count_field);
    print(prices);
    print(info_choice);
    print(date_work);
    print(details);
    print(map_lat_work);
    print(map_long_work);
    print(img1);
    print(img2);
    print(box1);
    print(box2);
    print(box3);
    print(box4);
    print(box5);
    print(box6);

    final uri = Uri.parse(
        "http://103.212.181.47/agriser_work/add_presentwork_labor.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_user"] = phone_user;
    request.fields["type_presentwork"] = type_presentwork;
    request.fields["count_field"] = count_field;
    request.fields["prices"] = prices;
    request.fields["info_choice"] = info_choice;
    request.fields["date_work"] = date_work;
    request.fields["details"] = details;
    request.fields["map_lat_work"] = map_lat_work.toString();
    request.fields["map_long_work"] = map_long_work.toString();
    request.fields["img1"] = img1;
    request.fields["img2"] = img2;
    request.fields["box1"] = box1;
    request.fields["box2"] = box2;
    request.fields["box3"] = box3;
    request.fields["box4"] = box4;
    request.fields["box5"] = box5;
    request.fields["box6"] = box6;
    request.fields["total_choice"] = total_choice;

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => List_user_presentwork_labor());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      print("UPLOAD");
      dialong(context, "ประกาศงานสำเร็จ");
    } else {
      print("UPLOAD FAIL");
    }
  }
}
