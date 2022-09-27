import 'dart:convert';
import 'dart:typed_data';

import 'package:agriser_work/pages/user/user_search/confirm_service_car.dart';
import 'package:agriser_work/pages/user/user_search/confirm_service_labor.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:agriser_work/utility/model_service_provider_labor.dart';
import 'package:agriser_work/utility/modelprovider.dart';
import 'package:agriser_work/utility/modeluser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Data_service_labor extends StatefulWidget {
  const Data_service_labor({Key? key}) : super(key: key);

  @override
  State<Data_service_labor> createState() => _Data_service_laborState();
}

class _Data_service_laborState extends State<Data_service_labor> {
  TextEditingController dateinput = TextEditingController();
  late String id_service,
      phone_provider,
      type,
      info_choice,
      prices,
      total_choice,
      image1,
      image2,
      total_price;

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

  late String use_name, use_province, phone_user;

  late double lat = 0, long = 0;
  late String count_file = "";
  late String formattedDate = "", load = "0";
  late Uint8List imgfromb64;
  List Allrating = [];
  List<int> allrate = [];
  late double showrating = 0;
  late int c = 0;

  @override
  void initState() {
    super.initState();
    findData();
    // findLocation();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_service = preferences.getString('id_service')!;
      phone_provider = preferences.getString('phone_provider')!;
      phone_user = preferences.getString('phone_user')!;
      print("------------ Data - Mode ------------");
      print("--- Get id_service State :     " + id_service);
      print("--- Get phone_provider State :     " + phone_provider);
    });
    LoadData_service();
    Loadrating();
  }

  Future LoadData_service() async {
    var url =
        "http://103.212.181.47/agriser_work/get_service_labor.php?isAdd=true&id_service=$id_service";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        ModelService_Pro_labor datauser = ModelService_Pro_labor.fromJson(map);
        setState(() {
          type = datauser.type;
          info_choice = datauser.info_choice;
          prices = datauser.prices;
          total_choice = datauser.total_choice;
          image1 = datauser.image1;
          image2 = datauser.image2;

          imgfromb64 = base64Decode(image1);

          LoadData_provider();
          LoadData_user();
        });
      }
    }
  }

  Future Loadrating() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/search_rating_provider.php?isAdd=true&phone_provider=$phone_provider");
    if (response.statusCode == 200) {
      setState(() {
        Allrating = json.decode(response.data);
      });
      print("-------------------------------------------------------");
      print(Allrating);
      sumrating();
      return Allrating;
    }
  }

  sumrating() {
    int a;
    for (var i = 0; i < Allrating.length; i++) {
      print(Allrating[i]['rating']);
      a = int.parse(Allrating[i]['rating']);
      allrate.add(a);
    }
    for (var i = 0; i < allrate.length; i++) {
      showrating += allrate[i];
    }
    setState(() {
      showrating = showrating / allrate.length;

      // c = showrating.toInt();
    });
    print("showrating : ${showrating}");
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

          lat = double.parse(p_map_lat);
          long = double.parse(p_map_long);

          Loadampure();
        });
      }
    }
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
          use_name = datauser.name;
          use_province = datauser.province;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("ข้อมูลเกี่ยวกับผู้ให้บริการ",
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
            color: Colors.green.shade400,
            onPressed: () async {
              if (count_file == "" || formattedDate == "") {
                dialong(context, "โปรดเลือกจำนวนไร่และวันที่ต้องการนัดหมาย");
              } else {
                int a = int.parse(count_file) * int.parse(prices);
                total_price = a.toString();

                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString("count_field", count_file);
                preferences.setString("date_work", formattedDate);
                preferences.setString("total_price", total_price);
                preferences.setString("show_img", image1);
                preferences.setString("show_type", type);
                preferences.setString("show_servicename", use_name);
                preferences.setString("show_province", use_province);
                preferences.setString("show_servicename_pro", p_name);
                preferences.setString("show_province_pro", p_province);

                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Confirm_service_labor());
                Navigator.push(context, route);
              }
            },
            child: Text("ยืนยัน",
                style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
          ),
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
      icon: BitmapDescriptor.defaultMarkerWithHue(220),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////

  Widget Countfield() => Container(
        height: 60,
        width: 100,
        child: TextField(
          keyboardType: TextInputType.number,
          style: GoogleFonts.mitr(fontSize: 18),
          onChanged: (value) => count_file = value.trim(),
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            hintText: "จำนวน",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget Dateform() => Container(
        padding: EdgeInsets.all(15),
        height: 100,
        width: 200,
        child: TextField(
          controller: dateinput,
          style: GoogleFonts.mitr(
              fontSize: 18), //editing controller of this TextField
          decoration: InputDecoration(
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "เลือกวันที่เริ่มงาน",
              labelStyle: GoogleFonts.mitr(
                fontSize: 18,
              ) //label text of field
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

  Widget load_data() => Container(
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
                  child: Text("ประเภท   :  ",
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
                  child: Text("ราคาต่อวัน :  ",
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
                  child: Text("คะแนนการให้บริการ   :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Text("${showrating.toStringAsFixed(1)}",
                  style: GoogleFonts.mitr(
                      fontSize: 18, color: Color.fromARGB(255, 4, 136, 11))),
            ],
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text("จำนวนวันที่ต้องการจ้าง  :  ",
                      style: GoogleFonts.mitr(fontSize: 16))),
              Allmethod().Space(),
              Countfield()
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
              Dateform()
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
          Text("- ที่อยู่ -", style: GoogleFonts.mitr(fontSize: 18)),
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

  Loadprovince2() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/showprovince.php?isAdd=true&id_province=$use_province");
    if (response.statusCode == 200) {
      List search_service = json.decode(response.data);
      print(search_service[0]["name_th"]);
      setState(() {
        use_province = search_service[0]["name_th"];
        load = "1";
      });
    }
  }
}
