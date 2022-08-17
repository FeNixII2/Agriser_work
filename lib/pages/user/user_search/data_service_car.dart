import 'dart:convert';

import 'package:agriser_work/pages/user/user_search/confirm_work.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/model_service_provider_car.dart';
import 'package:agriser_work/utility/modelprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Data_service_car extends StatefulWidget {
  const Data_service_car({Key? key}) : super(key: key);

  @override
  State<Data_service_car> createState() => _Data_service_carState();
}

class _Data_service_carState extends State<Data_service_car> {
  TextEditingController dateinput = TextEditingController();
  late String id_service, phone_provider;
  late String c_type,
      c_brand,
      c_model,
      c_datebuy,
      c_prices,
      c_image_car,
      c_image_car_2;

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

  late double lat = 0, long = 0;
  late String count_file, prices = "";
  late String formattedDate = "", load = "0";

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

      print("------------ Data - Mode ------------");
      print("--- Get id_service State :     " + id_service);
      print("--- Get phone_provider State :     " + phone_provider);
    });
    LoadData_service();
  }

  Future LoadData_service() async {
    var url =
        "http://192.168.1.4/agriser_work/getServiceWhereIdservice_car.php?isAdd=true&id_service=$id_service";
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
          c_image_car_2 = datauser.image_car_2;

          prices = c_prices;

          LoadData_provider();

          print("------------ Getinfo DataService ------------");
          print("--- Get id_service State :     " + id_service);
          print("--- Get c_type State :     " + c_type);
          print("--- Get c_brand State :     " + c_brand);
          print("--- Get c_model State :     " + c_model);
          print("--- Get c_datebuy State :     " + c_datebuy);
          print("--- Get c_prices State :     " + c_prices);
          print("--- Get c_image_car State :     " + c_image_car);
          print("--- Get c_image_car_2 State :     " + c_image_car_2);
        });
      }
    }
  }

  Future LoadData_provider() async {
    var url =
        "http://192.168.1.4/agriser_work/getProviderWherephone_provider.php?isAdd=true&phone_provider=$phone_provider";
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
          p_province = datauser.province;
          p_map_lat = datauser.map_lat;
          p_map_long = datauser.map_long;

          lat = double.parse(p_map_lat);
          long = double.parse(p_map_long);

          load = "1";

          print("------------ Getinfo DataProvider ------------");
          print("--- Get p_phone State :     " + p_phone);
          print("--- Get p_name State :     " + p_name);
          print("--- Get p_email State :     " + p_email);
          print("--- Get p_date State :     " + p_date);
          print("--- Get p_sex State :     " + p_sex);
          print("--- Get p_address State :     " + p_address);
          print("--- Get p_address State :     " + p_province);
          print("--- Get p_map_lat State :     " + p_map_lat);
          print("--- Get p_map_long State :     " + p_map_long);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("ข้อมูลเกี่ยวกับผู้ให้บริการ"),
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
      icon: BitmapDescriptor.defaultMarkerWithHue(1),
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

  Widget load_data() => Container(
        child: Column(
          children: [
            Container(
              child: Image.network(
                  "http://192.168.1.4/agriser_work/upload_image/${c_image_car}"),
            ),
            Row(
              children: [
                Text("ให้บริการเกี่ยวกับ   :  "),
                Allmethod().Space(),
                Text("$c_type"),
              ],
            ),
            Row(
              children: [
                Text("ชื่อ  :  "),
                Allmethod().Space(),
                Text("$p_name"),
              ],
            ),
            Row(
              children: [
                Text("เบอร์โทร  :  "),
                Allmethod().Space(),
                Text("$p_phone"),
              ],
            ),
            Row(
              children: [
                Text("อีเมลล์  :  "),
                Allmethod().Space(),
                Text("$p_email"),
              ],
            ),
            Row(
              children: [
                Text("ที่อยู่  :  "),
                Allmethod().Space(),
                Text("$p_address"),
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
                Text("ราคาต่อไร่  :  "),
                Allmethod().Space(),
                Text("$c_prices"),
              ],
            ),
            Row(
              children: [
                Text("จำนวนไร่ที่ต้องการจ้าง  :  "),
                Allmethod().Space(),
                Countfield(),
              ],
            ),
            Row(
              children: [
                Text("วันที่ต้องการจ้าง  :  "),
                Allmethod().Space(),
                Dateform(),
              ],
            ),
            showmap(),
            RaisedButton(
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
          ],
        ),
      );
}