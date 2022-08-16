import 'dart:async';
import 'dart:convert';

import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utility/allmethod.dart';
import '../../provider/all_bottombar_provider.dart';
import '../user_search.dart';
import 'confirm_work.dart';

class Data_list_service extends StatefulWidget {
  const Data_list_service({Key? key}) : super(key: key);

  @override
  State<Data_list_service> createState() => Data_list_serviceState();
}

class Data_list_serviceState extends State<Data_list_service> {
  TextEditingController dateinput = TextEditingController();

  List search_service = [];

  late String id_service = "";
  late String number_;
  late String formattedDate = "";
  late String slat, slong;
  late double lat = 0, long = 0;
  int result = 0;
  late String phone_provider_u_c_p;
  late String gphone = "", gtype = "", gbrand = "";

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    findData();
  }

  Future<Null> findData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_service = preferences.getString('id_service')!;
      slat = preferences.getString('lat_provider')!;
      slong = preferences.getString('long_provider')!;
      phone_provider_u_c_p = preferences.getString('phone_provider_u_c_p')!;
      lat = double.parse(slat);
      long = double.parse(slong);

      print("------------ Data - Mode ------------");
      print("--- Get id_service State :     " + id_service);
      print("--- Get lat_provider State :     " + slat);
      print("--- Get long_provider State :     " + slong);
      print("--- Get phone_provider_u_c_p State :     " + phone_provider_u_c_p);
    });
    LoadData_service();
    // Loadservice();
  }

  Future LoadData_service() async {
    print("------------ Getinfo DataService ------------");
    print("--- Get id_service State :     " + id_service);
    var url =
        "http://192.168.1.4/agriser_work/getServiceWhereIdservice.php?isAdd=true&id_service=$id_service";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        ModelService_Pro_car datauser = ModelService_Pro_car.fromJson(map);
        setState(() {
          print(
              "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          gphone = datauser.phone_provider;
          gtype = datauser.type;
          gbrand = datauser.brand;
          // date_provider = datauser.date;
          // sex_provider = datauser.sex;
          // address_provider = datauser.address;
          // province_provider = datauser.province;
          // district_provider = datauser.district;
          // map_lat_provider = datauser.map_lat;
          // map_long_provider = datauser.map_long;

          print(gphone);
          print(gtype);
          print(gbrand);
        });
      }
    }

    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString("name_user", name_user);
    // preferences.setString("email_user", email_provider);
    // preferences.setString("address_user", address_provider);
    // preferences.setString("province_user", province_provider);
    // preferences.setString("district_user", district_provider);
    // preferences.setString("map_lat_user", map_lat_provider);
    // preferences.setString("map_long_user", map_long_provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("ข้อมูลทั้งหมด"),
        // centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: search_service.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Allmethod().Space(),
                    Center(
                      child: Container(
                        child: Image.network(
                          "http://192.168.1.4/agriser_work/upload_image/${search_service[index]['image_car']}",
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      '${search_service[index]['name_provider']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 26.0,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
                    Text(
                      'เบอร์โทรติดต่อ ${search_service[index]['phone_provider']}',
                      style: const TextStyle(fontSize: 22.0),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Text(
                      'ผู้ให้บริการ ${search_service[index]['type']}',
                      style: const TextStyle(fontSize: 22.0),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                    Text(
                      'ราคาต่อไร่ ${search_service[index]['prices']} บาท/ไร่',
                      style: const TextStyle(fontSize: 22.0),
                    ),
                    Allmethod().Space(),
                    Row(
                      children: [
                        Text(
                          'จำนวนจ้าง ',
                          style: const TextStyle(fontSize: 22.0),
                        ),
                        Number_(),
                        Text(
                          ' ไร่',
                          style: const TextStyle(fontSize: 22.0),
                        ),
                      ],
                    ),
                    Allmethod().Space(),
                    Dateform(),
                    Allmethod().Space(),
                    Container(
                      child: FutureBuilder(builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (lat != 0) {
                          return showmap();
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                    ),
                    Allmethod().Space(),
                    Center(
                      child: RaisedButton(
                        onPressed: () => accept(
                          formattedDate,
                          number_,
                          search_service[index]['name_provider'],
                          search_service[index]['phone_provider'],
                          search_service[index]['type'],
                          search_service[index]['prices'],
                        ),
                        child: Text("ถัดไป"),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget Number_() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => number_ = value.trim(),
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

  Loadservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/all_data_provider.php?isAdd=true&id_service=$id_service");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      // print('เข้ามานี่ไหมนิ');
      return search_service;
    }
  }

  Widget Dateform() => Container(
      padding: EdgeInsets.all(15),
      height: 100,
      width: 300.0,
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
      ));

  void accept(date, number_, name, phone, type, price) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("date_startwork", date);
    preferences.setString("number_", number_);
    preferences.setString("name_provider", name);
    preferences.setString("phone_provider", phone);
    preferences.setString("type", type);
    preferences.setString("price", price);
    

    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => Confirm_work());
    Navigator.push(context, route);
    // print(int.parse(number_) * int.parse(price));
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
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
    );
  }

  Set<Marker> marker() {
    return <Marker>[mylocation()].toSet();
  }

  //////////////////////////////////// END MAP ///////////////////////////////
  ///
  ///
  ///

}
