import 'dart:convert';

import 'package:agriser_work/regis_setmap.dart';
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
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late double lat = 0;
  late double long = 0;

  @override
  void initState() {
    super.initState();
    getAllprovince();
  }

  late String name_user = "";
  late String phone_user = "";
  late String password_user = "";
  late String password_user_a = "";
  late String email_user = "";
  late String date_user = "";
  late String sex_user = "";
  late String address_user = "";
  // late String province_user = "";
  // late String district_user = "";
  late String pickedDate = "";
  late String formattedDate = "", load = "0";
  bool isChecked_b = false;
  bool isChecked_g = false;

  TextEditingController dateinput = TextEditingController();

  //// จังหวัด
  var selectProvince;
  var selectAmphure;
  List dataProvince = [];
  List dataAmphure = [];

  Future getAllprovince() async {
    // print("เข้าแล้วเน้อ");

    var url = "http://103.212.181.47/agriser_work/getProvince.php?isAdd=true";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dataProvince = jsonData;
        // data = jsonData;
      });
      // print(dataProvince);
      // return dataProvince;
    }
  }

  Future getSelectAmphures() async {
    // print("มาอำเภอ");
    var url =
        "http://103.212.181.47/agriser_work/getSelectAmphures.php?isAdd=true&&idprovince=$selectProvince";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dataAmphure = jsonData;
        // data = jsonData;
      });

      // print(dataAmphure);
      // return dataAmphure;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Color.fromARGB(255, 229, 160, 10);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียนผู้ใช้", style: GoogleFonts.mitr(fontSize: 18)),
        backgroundColor: Allmethod().dartcolor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => Login());
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Showlogo(),
            Allmethod().Space(),
            Telform(),
            Allmethod().Space(),
            Passwordform(),
            Allmethod().Space(),
            Passwordform_a(),
            Allmethod().Space(),
            Nameform(),
            Allmethod().Space(),
            Emailform(),
            Allmethod().Space(),
            Addressform(),
            Allmethod().Space(),
            districT(),
            Allmethod().Space(),
            provincE(),
            Allmethod().Space(),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Sexform_male(),
                  Sexform_frmale(),
                ]),
            Dateform(),
            Allmethod().Space(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
              color: Allmethod().dartcolor,
              onPressed: () async {
                if (phone_user == null ||
                    phone_user.isEmpty ||
                    name_user == null ||
                    name_user.isEmpty ||
                    password_user == null ||
                    password_user.isEmpty ||
                    password_user_a == null ||
                    password_user_a.isEmpty ||
                    sex_user == null ||
                    sex_user.isEmpty ||
                    address_user == null ||
                    address_user.isEmpty ||
                    formattedDate == null ||
                    formattedDate.isEmpty ||
                    selectProvince == null ||
                    selectProvince.isEmpty ||
                    selectAmphure == null ||
                    selectAmphure.isEmpty) {
                  dialong(context, "กรุณากรอกข้อมูลให้ครบทุกช่อง");
                  print("กรอกข้อมูลไม่ครบ");
                } else {
                  if (password_user == password_user_a) {
                    if (phone_user.length != 10) {
                      dialong(context, "กรุณากรอกเบอร์โทรให้ครบ");
                    } else {
                      if (password_user.length < 6) {
                        dialong(context, "กรุณากรอกรหัสผ่านอย่างน้อย 6 ตัว");
                      } else {
                        checktel();
                      }
                    }
                  } else {
                    dialong(context,
                        "รหัสผ่านของคุณไม่ตรงกัน กรุณาลองใหม่อีกครั้ง");
                  }
                }
              },
              child: Text(
                "ถัดไป",
                style: GoogleFonts.mitr(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  Widget districT() => Container(
        child: DropdownButton(
            hint: Text("เลือกจังหวัด", style: GoogleFonts.mitr(fontSize: 18)),
            value: selectProvince,
            items: dataProvince.map((provinces) {
              return DropdownMenuItem(
                  value: provinces['id'],
                  child: Text(provinces['name_th'],
                      style: GoogleFonts.mitr(fontSize: 18)));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectProvince = value;
                // print(selectProvince);
                getSelectAmphures();
              });
            }),
      );

  Widget provincE() => Container(
        child: DropdownButton(
            hint: Text("เลือกอำเภอ", style: GoogleFonts.mitr(fontSize: 18)),
            value: selectAmphure,
            items: dataAmphure.map((amphures) {
              return DropdownMenuItem(
                  value: amphures['id'],
                  child: Text(amphures['name_th'],
                      style: GoogleFonts.mitr(fontSize: 18)));
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectAmphure = value;
                // print(selectAmphure);
              });
            }),
      );

  void checktel() async {
    var dio = Dio();
    final response = await dio.get(
        "http://103.212.181.47/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user");

    print(response.data);
    // print('check ^^^^');
    if (response.data == "null") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("phone_user", phone_user);
      preferences.setString("password_user", password_user);
      preferences.setString("name_user", name_user);
      preferences.setString("email_user", email_user);
      preferences.setString("date_user", formattedDate);
      preferences.setString("sex_user", sex_user);
      preferences.setString("address_user", address_user);
      preferences.setString("amphures", selectAmphure);
      preferences.setString("province", selectProvince);

      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Regis_setmap());
      Navigator.push(context, route);
    } else {
      dialong(context, "เบอร์ $phone_user ถูกใช้งานแล้ว กรุณาลองใหม่");
    }
  }

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => name_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "ชื่อ-นามสกุล",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

  Widget Telform() => Container(
        width: 300.0,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLength: 10,
          textInputAction: TextInputAction.go,
          onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "เบอร์โทรศัพท์",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

  Widget Passwordform() => Container(
        width: 300.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "รหัสผ่าน",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

  Widget Passwordform_a() => Container(
        width: 300.0,
        child: TextField(
          obscureText: true,
          onChanged: (value) => password_user_a = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "ยืนยันรหัสผ่าน",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

  Widget Emailform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => email_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "อีเมล",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

  Widget Dateform() => Container(
      padding: EdgeInsets.all(15),
      height: 100,
      width: 300.0,
      child: TextField(
        controller: dateinput,
        style: GoogleFonts.mitr(
            fontSize: 18), //editing controller of this TextField
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "เลือกวันเกิด",
          labelStyle: GoogleFonts.mitr(fontSize: 18), //label text of field
        ),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          var format = DateFormat.yMMMEd();
          var dateTime = DateTime.now();
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: dateTime,
              firstDate: DateTime(
                  1950), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime.now());

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            print(formattedDate);
            //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement

            setState(() {
              dateinput.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {
            print("Date is not selected");
          }
        },
      ));

  Widget Sexform_male() => Container(
        width: 140.0,
        child: CheckboxListTile(
          title: Text(
            "ชาย",
            style: GoogleFonts.mitr(fontSize: 18),
          ),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_b,
          onChanged: (bool? value) {
            setState(() {
              isChecked_b = value!;
              isChecked_g = false;
              sex_user = '1';
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget Sexform_frmale() => Container(
        width: 150.0,
        child: CheckboxListTile(
          title: Text(
            "หญิง",
            style: GoogleFonts.mitr(fontSize: 18),
          ),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_g,
          onChanged: (bool? value) {
            setState(() {
              isChecked_g = value!;
              isChecked_b = false;
              sex_user = '2';
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget Addressform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => address_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle:
                GoogleFonts.mitr(fontSize: 18, color: Allmethod().dartcolor),
            labelText: "ที่อยู่ปัจจุบัน",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );

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
      height: 300,
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
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  ////////////////////////////////////    END   MAP   ///////////////////////////////////////////
}
