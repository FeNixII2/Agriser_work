import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/setmap_presentwork_car.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utility/allmethod.dart';
import 'dart:io' as Io;

class Add_user_presentwork_car extends StatefulWidget {
  const Add_user_presentwork_car({Key? key}) : super(key: key);

  @override
  State<Add_user_presentwork_car> createState() =>
      _Add_user_presentwork_carState();
}

class _Add_user_presentwork_carState extends State<Add_user_presentwork_car> {
  late File img_1;
  late File img_2;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check1 = false;
  bool check2 = false;
  String type = "";
  String count_field = "";
  String prices = "";
  String date_buy = "";
  String more_details = "ไม่มี";
  String image1 = "";
  String image2 = "";

  late Uint8List imgfromb64;

  late String name_user;
  late String phone_user;
  late String map_lat_user;
  late String map_long_user;
  TextEditingController dateinput = TextEditingController();
  late String formattedDate = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString("choose_type_service")!;

      phone_user = preferences.getString('phone_user')!;
      print("------------ user - Mode ------------");
      print("--- Get type user State :     " + type);

      print("--- Get phone user State :     " + phone_user);
    });
  }

  Future chooseImage1() async {
    var pickImage1 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      img_1 = File(pickImage1!.path);
      String name_img1 = img_1.path.split("/").last;

      check1 = true;
      print("Path File img_1  :    $img_1 ");
      print("Name img_1  :    $name_img1 ");

      final bytes = Io.File(img_1.path).readAsBytesSync();
      image1 = base64Encode(bytes);

      // imgfromb64 = base64Decode(image1);
    });
  }

  Future chooseImage2() async {
    var pickImage2 = await picker2.getImage(source: ImageSource.gallery);
    setState(() {
      img_2 = File(pickImage2!.path);
      String name_img2 = img_2.path.split("/").last;

      check2 = true;
      print("Path File img_2  :    $img_2 ");
      print("Name img_2  :    $name_img2 ");

      final bytes = Io.File(img_2.path).readAsBytesSync();
      image2 = base64Encode(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียดจ้างงาน",
          style: GoogleFonts.mitr(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("งานประกาศ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  type_car(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("จำนวนไร่ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_count_field(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ราคาจ่าย :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_price(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รายละเอียดเพิ่มเติม :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_moreinfo(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("วันที่นัดหมาย :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  Dateform(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปภาพพื้นที่1 :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  display1(),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปภาพพื้นที่2 :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  display2(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
              color: Colors.green.shade400,
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString("count", count_field);
                preferences.setString("prices", prices);
                preferences.setString("date_work", formattedDate);
                preferences.setString("details", more_details);

                preferences.setString("img1", image1);
                preferences.setString("img2", image2);

                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Setmap_presentwork_car());
                Navigator.push(context, route);
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

  Widget type_car() => Container(
      height: 60,
      width: 200,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type = value.trim(),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: type,
            fillColor: Colors.white70),
      ));

  Widget box_count_field() => Container(
        height: 60,
        width: 200,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => count_field = value.trim(),
          decoration: InputDecoration(
            hintText: "จำนวนไร่",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_price() => Container(
        height: 60,
        width: 200,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => prices = value.trim(),
          decoration: InputDecoration(
            hintText: "ราคา",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_moreinfo() => Container(
        height: 100,
        width: 200,
        child: TextField(
          onChanged: (value) => more_details = value.trim(),
          decoration: InputDecoration(
            hintText: "รายละเอียดเพิ่มเติม",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
          minLines: 1,
          maxLines: 5,
        ),
      );

  Widget display1() => Container(
        child: check1 == false
            ? IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage1();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage1();
                },
                icon: Image.file(img_1),
              ),
      );

  Widget display2() => Container(
        child: check2 == false
            ? IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage2();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage2();
                },
                icon: Image.file(img_2),
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
}
