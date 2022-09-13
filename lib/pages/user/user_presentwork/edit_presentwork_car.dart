import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/setmap_presentwork_car.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/model_presentwork_car.dart';
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

class Edit_presentwork_car extends StatefulWidget {
  const Edit_presentwork_car({Key? key}) : super(key: key);

  @override
  State<Edit_presentwork_car> createState() => _Edit_presentwork_carState();
}

class _Edit_presentwork_carState extends State<Edit_presentwork_car> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController c_count_field = TextEditingController();
  TextEditingController c_prices = TextEditingController();
  TextEditingController c_details = TextEditingController();
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
  String more_details = "";
  String image1 = "";
  String image2 = "";

  List search_service = [];

  late Uint8List imgfromb64, imgfromb642;

  late String name_user;
  late String phone_user;
  late String map_lat_user;
  late String map_long_user;

  late String formattedDate = "", load = "0";

  late String id_presentwork,
      type_presentwork,
      img_field1,
      img_field2,
      date_work,
      details,
      map_lat_work,
      map_long_work;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      print("load data");
      id_presentwork = preferences.getString("id_presentwork")!;
      print("$id_presentwork");
      phone_user = preferences.getString('phone_user')!;
      print("load data");
      LoadData_presentwork();
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

      imgfromb64 = base64Decode(image1);
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
      body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (load != "0") {
          return loaddata();
        }
        return Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
              color: Colors.green.shade400,
              onPressed: () async {
                Alertlogout();
              },
              child: Text(
                "ลบประกาศ",
                style: GoogleFonts.mitr(
                  fontSize: 18,
                  color: Colors.white,
                ),
              )),
        ),
      ),
    );
  }

  Widget loaddata() => SingleChildScrollView(
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
                      child: Text("รายละเอียด :",
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
      );

  Widget type_car() => Container(
      height: 60,
      width: 200,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type = value.trim(),
        style: GoogleFonts.mitr(fontSize: 18),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            hintText: type,
            fillColor: Colors.white70),
      ));

  Widget box_count_field() => Container(
        height: 60,
        width: 200,
        child: TextField(
          // controller: c_count_field,
          keyboardType: TextInputType.number,
          onChanged: (value) => count_field = value.trim(),
          style: GoogleFonts.mitr(fontSize: 18),
          decoration: InputDecoration(
            hintText: "$count_field",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_price() => Container(
        height: 60,
        width: 200,
        child: TextField(
          // controller: c_prices,
          keyboardType: TextInputType.number,
          onChanged: (value) => prices = value.trim(),
          style: GoogleFonts.mitr(fontSize: 18),
          decoration: InputDecoration(
            hintText: "$prices",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_moreinfo() => Container(
        height: 100,
        width: 200,
        child: TextField(
          // controller: c_details,
          onChanged: (value) => more_details = value.trim(),
          style: GoogleFonts.mitr(fontSize: 18),
          decoration: InputDecoration(
            hintText: "$details",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
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
                iconSize: 180,
                onPressed: () {
                  // chooseImage1();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.memory(imgfromb64),
              )
            : IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage1();
                },
                icon: Image.file(img_1),
              ),
      );

  Widget display2() => Container(
        child: check2 == false
            ? IconButton(
                iconSize: 180,
                onPressed: () {
                  // chooseImage2();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.memory(imgfromb642),
              )
            : IconButton(
                iconSize: 180,
                onPressed: () {
                  chooseImage2();
                },
                icon: Image.file(img_2)),
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
              labelStyle: GoogleFonts.mitr(fontSize: 18) //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            // var dateTime = DateTime.now();
            // DateTime? pickedDate = await showDatePicker(
            //     context: context,
            //     initialDate: dateTime,
            //     firstDate: DateTime(
            //         1950), //DateTime.now() - not to allow to choose before today.
            //     lastDate: DateTime.utc(dateTime.year, dateTime.month + 1,
            //         dateTime.day, dateTime.hour, dateTime.minute));

            // if (pickedDate != null) {
            //   print(
            //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            //   formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
            //   print(
            //       formattedDate); //formatted date output using intl package =>  2021-03-16
            //   //you can implement different kind of Date Format here according to your requirement

            //   setState(() {
            //     dateinput.text =
            //         formattedDate; //set output date to TextField value.
            //   });
            // } else {
            //   print("Date is not selected");
            // }
          },
        ),
      );

  Future LoadData_presentwork() async {
    var url =
        "http://192.168.1.4/agriser_work/get_presentwork_car.php?isAdd=true&id_presentwork=$id_presentwork";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modelpresentwork_car datauser = Modelpresentwork_car.fromJson(map);
        setState(() {
          print(
              "-----------------------------------------------------------------");

          phone_user = datauser.phone_user;
          type = datauser.type_presentwork;
          count_field = datauser.count_field;
          img_field1 = datauser.img_field1;
          img_field2 = datauser.img_field2;
          date_work = datauser.date_work;
          details = datauser.details;
          prices = datauser.prices;
          map_lat_work = datauser.map_lat_work;
          map_long_work = datauser.map_long_work;

          imgfromb64 = base64Decode(img_field1);
          imgfromb642 = base64Decode(img_field2);

          c_count_field.text = count_field;
          c_prices.text = prices;
          c_details.text = details;
          dateinput.text = date_work;

          load = "1";
          print("asdasdasdasdasd");
        });
      }
    }
  }

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ลบงานประกาศ', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการลบงานประกาศนี้ใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        delete_presentwork();
      },
    );
  }

  Load_psk() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/search_schedule_presentwork_pru.php?isAdd=true&phone_user=$phone_user&id_presentwork=$id_presentwork");
    if (response.statusCode == 200) {
      setState(() {
        search_service = json.decode(response.data);
      });
      print(search_service);
      return search_service;
    }
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('ยกเลิก', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  delete_presentwork() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/delete_presentwork_car.php?isAdd=true&id_presentwork=$id_presentwork");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => List_user_presentwork_car());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลบงานประกาศแล้ว");
    } else {}
  }
}
