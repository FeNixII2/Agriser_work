import 'dart:convert';

import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utility/allmethod.dart';
import '../../provider/all_bottombar_provider.dart';
import '../../provider/provider_service/type_provider_service.dart';
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

  late String id_service;
  late String number_;
  late String formattedDate = "";
  int result = 0;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_service = preferences.getString('id_service')!;
      print("------------ Data - Mode ------------");

      print("--- Get data provider State :     " + id_service);
    });
    Loadservice();
  }

  Future getinfo_service() async {
    var url = "http://192.168.88.213/agriser_work/get_img.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const All_bottombar_user()),
          ),
        ),
        title: Text("ข้อมูลทั้งหมด"),
        // centerTitle: true,
      ),
      body: ListView.builder(
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
                        "http://192.168.88.213/agriser_work/upload_image/${search_service[index]['image_car']}",
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
        "http://192.168.88.213/agriser_work/all_data_provider.php?isAdd=true&id_service=$id_service");
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
}
