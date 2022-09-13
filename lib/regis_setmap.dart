import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Regis_setmap extends StatefulWidget {
  const Regis_setmap({Key? key}) : super(key: key);

  @override
  State<Regis_setmap> createState() => _Regis_setmapState();
}

class _Regis_setmapState extends State<Regis_setmap> {
  late double lat, long;
  late String load = "0";
  late String name_user = "";
  late String phone_user = "";
  late String password_user = "";

  late String email_user = "";
  late String date_user = "";
  late String sex_user = "";
  late String address_user = "";
  late String amphures = "";
  late String province = "";
  // late String province_user = "";
  // late String district_user = "";
  late String pickedDate = "";
  late String formattedDate = "";

  @override
  void initState() {
    super.initState();
    getdata();
    findLocation();
  }

  Future<Null> getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      phone_user = preferences.getString('phone_user')!;
      password_user = preferences.getString('password_user')!;
      name_user = preferences.getString('name_user')!;
      email_user = preferences.getString('email_user')!;
      date_user = preferences.getString('date_user')!;
      sex_user = preferences.getString('sex_user')!;
      address_user = preferences.getString('address_user')!;
      amphures = preferences.getString('amphures')!;
      province = preferences.getString('province')!;

      print("------------ User - Mode ------------");

      print("--- Get phone user State :     " + phone_user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("เลือกตำแหน่งที่อยู่", style: GoogleFonts.mitr(fontSize: 18)),
        backgroundColor: Allmethod().dartcolor,
      ),
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (load != "0") {
          return showmap();
        }
        return Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Allmethod().dartcolor,
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

  void registhread() async {
    if (email_user == null || email_user.isEmpty) {
      email_user = '-';
    }
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/addUser.php?isAdd=true&tel=$phone_user&pass=$password_user&name=$name_user&date=$date_user&sex=$sex_user&address=$address_user&province=$province&amphures=$amphures&email=$email_user&map_lat_user=$lat&map_long_user=$long");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Login());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  //////////////////////////////   MAP     //////////////////////////////////
  Future<Null> findLocation() async {
    LocationData? locationData = await findLocationData();
    setState(() {
      lat = locationData!.latitude!;
      long = locationData.longitude!;
      print("lat = $lat , long = $long");
      load = "1";
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
    LatLng latLng = LatLng(lat, long);
    CameraPosition Location_user = CameraPosition(target: latLng, zoom: 17);

    return Container(
      height: 612,
      // width: 300,
      child: GoogleMap(
        onTap: (LatLng laalongg) {
          setState(() {
            lat = laalongg.latitude;
            long = laalongg.longitude;
            print("lat = $lat , long = $long");
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
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(120),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  ////////////////////////////////////    END   MAP   ///////////////////////////////////////////

  void Alertconfirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('ยืนยันลงทะเบียน', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการสมัครใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        registhread();
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
