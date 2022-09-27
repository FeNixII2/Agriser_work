import 'dart:convert';

import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/modeluser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Edit_user_data extends StatefulWidget {
  const Edit_user_data({Key? key}) : super(key: key);

  @override
  State<Edit_user_data> createState() => _Edit_user_dataState();
}

class _Edit_user_dataState extends State<Edit_user_data> {
  late String name,
      email,
      date,
      sex,
      address,
      province,
      district,
      map_lat,
      map_long,
      phone_user;

  late String load = "0";
  late double lat, long;

  @override
  void initState() {
    super.initState();

    findData();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      phone_user = preferences.getString('phone_user')!;
    });

    LoadData_user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Text("ข้อมูลส่วนตัว", style: GoogleFonts.mitr(fontSize: 18)),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (load != "0") {
                return data();
              }
              return Center(child: CircularProgressIndicator());
            }),
          ],
        ),
      ),
    );
  }

  data() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 202,
                      height: 202,
                      child: Image.asset('assets/images/user.png'),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("ชื่อ-นามสกุล: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$name",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("เบอร์โทรศัพท์: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$phone_user",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("อีเมลล์: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$email",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("ข้อมูลที่อยู่: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$address",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("อำเภอ: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$district",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("จังหวัด: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$province",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("เพศ: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child:
                            Text("$sex", style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text("วันเกิด: ",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    Allmethod().Space(),
                    Container(
                        width: 202,
                        child: Text("$date",
                            style: GoogleFonts.mitr(fontSize: 18)))
                  ],
                ),
                Allmethod().Space(),
                Text("ข้อมูลที่อยู่", style: GoogleFonts.mitr(fontSize: 18)),
                Allmethod().Space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: FutureBuilder(builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (load != "0") {
                          return showmap();
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future LoadData_user() async {
    var url =
        "http://103.212.181.47/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modeluser datauser = Modeluser.fromJson(map);
        setState(() {
          name = datauser.name;
          email = datauser.email;
          date = datauser.date;
          sex = datauser.sex;
          address = datauser.address;
          district = datauser.district;
          province = datauser.province;
          map_lat = datauser.map_lat;
          map_long = datauser.map_long;

          lat = double.parse(map_lat);
          long = double.parse(map_long);

          print("1");

          if (sex == "1") {
            sex = "ชาย";
          } else {
            sex = "หญิง";
          }

          Loadampure();
        });
      }
    }
  }

  Loadampure() async {
    print("2");
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/showamphure.php?isAdd=true&id_district=$district");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        district = search_service[0]["name_th"];
        Loadprovince();
      });
    }
  }

  Loadprovince() async {
    print("2");
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/showprovince.php?isAdd=true&id_province=$province");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        province = search_service[0]["name_th"];
        load = "1";
      });
    }
  }

  ////////////////////////////////////   MAP  //////////////////////////////////////////////////////////////

  Container showmap() {
    LatLng latLng = LatLng(lat, long);
    CameraPosition Location_user = CameraPosition(target: latLng, zoom: 17);

    return Container(
      height: 200,
      width: 350,
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
      icon: BitmapDescriptor.defaultMarkerWithHue(120),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////
}
