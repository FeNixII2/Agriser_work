import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utility/allmethod.dart';
import 'dart:io' as Io;

class Add_provider_service_car extends StatefulWidget {
  const Add_provider_service_car({Key? key}) : super(key: key);

  @override
  State<Add_provider_service_car> createState() =>
      _Add_provider_service_carState();
}

class _Add_provider_service_carState extends State<Add_provider_service_car> {
  late File img1;
  late File img2;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check1 = false;
  bool check2 = false;
  late String phone_provider,
      type,
      brand = "",
      model = "",
      date_buy = "",
      prices = "",
      image1 = "",
      image2 = "",
      status_work;

  late Uint8List imgfromb64;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString("choose_type_service")!;

      phone_provider = preferences.getString('phone_provider')!;

      print("------------ Provider - Mode ------------");
      print("--- Get type provider State :     " + type);

      print("--- Get phone provider State :     " + phone_provider);
    });
  }

  Future chooseImage1() async {
    var pickImage1 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      img1 = File(pickImage1!.path);
      check1 = true;
      String name_img1 = img1.path.split("/").last;

      check1 = true;
      print("Path File img_1  :    $img1 ");
      print("Name img_1  :    $name_img1 ");

      final bytes = Io.File(img1.path).readAsBytesSync();
      image1 = base64Encode(bytes);
    });
  }

  Future chooseImage2() async {
    var pickImage2 = await picker2.getImage(source: ImageSource.gallery);
    setState(() {
      img2 = File(pickImage2!.path);
      check2 = true;
      String name_img2 = img2.path.split("/").last;

      check1 = true;
      print("Path File img_1  :    $img2 ");
      print("Name img_2  :    $name_img2 ");

      final bytes = Io.File(img2.path).readAsBytesSync();
      image2 = base64Encode(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดให้บริการ",
            style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
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
                      child: Text("งานบริการ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  type_car(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ยี่ห้อรถ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_brand(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รุ่นรถ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_model(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ปีที่ซื้อรถ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_date_buy(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ราคาต่อไร่ :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_prices(),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปประกอบที่1 :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  display1(),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปประกอบที่2 :",
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
              color: Colors.blue,
              onPressed: () async {
                if (brand == "" ||
                    prices == "" ||
                    date_buy == "" ||
                    model == "" ||
                    image1 == "" ||
                    image2 == "") {
                  dialong(context, "กรุณากรอกข้อมูลและแนปรูปภาพ");
                } else {
                  Alertconfirm();
                }
              },
              child: Text(
                "ยืนยัน",
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
        style: GoogleFonts.mitr(fontSize: 18),
        onChanged: (value) => type = value.trim(),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            hintText: type,
            fillColor: Colors.white70),
      ));

  Widget box_brand() => Container(
        height: 60,
        width: 200,
        child: TextField(
          style: GoogleFonts.mitr(fontSize: 18),
          onChanged: (value) => brand = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง คูโบต้า",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_model() => Container(
        height: 60,
        width: 200,
        child: TextField(
          style: GoogleFonts.mitr(fontSize: 18),
          onChanged: (value) => model = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง K15G4",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_date_buy() => Container(
        height: 60,
        width: 200,
        child: TextField(
          style: GoogleFonts.mitr(fontSize: 18),
          keyboardType: TextInputType.number,
          onChanged: (value) => date_buy = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง 2560",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_prices() => Container(
        height: 60,
        width: 200,
        child: TextField(
          style: GoogleFonts.mitr(fontSize: 18),
          keyboardType: TextInputType.number,
          onChanged: (value) => prices = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง 800",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget display1() => Container(
        child: check1 == false
            ? IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage1();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage1();
                },
                icon: Image.file(
                  img1,
                  fit: BoxFit.fitWidth,
                ),
              ),
      );

  Widget display2() => Container(
        child: check2 == false
            ? IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage2();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage2();
                },
                icon: Image.file(
                  img2,
                  fit: BoxFit.fitWidth,
                ),
              ),
      );

  void Alertconfirm() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('ลงทะเบียนบริการ', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการให้บริการนี้ใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        upload_service_car();
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

  Future upload_service_car() async {
    final uri =
        Uri.parse("http://192.168.1.4/agriser_work/add_service_car.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_provider"] = phone_provider;
    request.fields["type"] = type;
    request.fields["brand"] = brand;
    request.fields["prices"] = prices;
    request.fields["model"] = model;
    request.fields["date_buy"] = date_buy;
    request.fields["prices"] = prices;

    request.fields["image1"] = image1;
    request.fields["image2"] = image2;

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => List_provider_service_car());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      print("UPLOAD");
      dialong(context, "ลงทะเบียนบริการสำเร็จ");
    } else {
      print("UPLOAD FAIL");
    }
  }
}
