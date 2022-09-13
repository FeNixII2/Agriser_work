import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/setmap_presentwork_labor.dart';
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

class Add_user_presentwork_labor extends StatefulWidget {
  const Add_user_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Add_user_presentwork_labor> createState() =>
      _Add_user_presentwork_laborState();
}

class _Add_user_presentwork_laborState
    extends State<Add_user_presentwork_labor> {
  late File img1;
  late File img2;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check1 = false;
  bool check2 = false;
  bool check_choice = true;
  final fieldText = TextEditingController();
  late Uint8List imgfromb64;
  late String image1 = "", image2 = "";
  List total_choice = [];

  late String phone_user,
      type_presentwork,
      count_field = "",
      img_field1 = "",
      img_field2 = "",
      date_work = "",
      details = "",
      prices = "",
      info_choice = "";

  bool isChecked_box1 = false;
  bool isChecked_box2 = false;
  bool isChecked_box3 = false;
  bool isChecked_box4 = false;
  bool isChecked_box5 = false;
  bool isChecked_box6 = false;

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
      type_presentwork = preferences.getString("choose_type_service")!;

      phone_user = preferences.getString('phone_user')!;
      print("------------ Provider - Mode ------------");
      print("--- Get type provider State :     " + type_presentwork);

      print("--- Get phone provider State :     " + phone_user);
    });
  }

  Future chooseImage1() async {
    var pickImage1 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      img1 = File(pickImage1!.path);
      check1 = true;
      String name_img1 = img1.path.split("/").last;

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

      print("Path File img_1  :    $img2 ");
      print("Name img_1  :    $name_img2 ");

      final bytes = Io.File(img2.path).readAsBytesSync();
      image2 = base64Encode(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดจ้างงาน", style: GoogleFonts.mitr(fontSize: 18)),
        backgroundColor: Colors.green.shade400,
      ),
      body: Container(
        height: 615,
        child: SingleChildScrollView(
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
                    type_car()
                  ],
                ),
                Allmethod().Space(),
                Text("เลือกประเภท", style: GoogleFonts.mitr(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [box1(), box2()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [box3(), box4()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [box5(), box6()],
                ),
                Row(
                  children: [
                    Container(
                        width: 150,
                        child: Text("ประเภทเพิ่มเติม :",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    choice(),
                  ],
                ),
                Allmethod().Space(),
                Row(
                  children: [
                    Container(
                        width: 150,
                        child: Text("จำนวนไร่ :",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    b_count_field(),
                  ],
                ),
                Allmethod().Space(),
                Row(
                  children: [
                    Container(
                        width: 150,
                        child: Text("ราคาจ่าย :",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    prieces(),
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
                        child: Text("รายละเอียดเพิ่มเติม :",
                            style: GoogleFonts.mitr(fontSize: 18))),
                    more_details(),
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: RaisedButton(
            color: Colors.green.shade400,
            onPressed: () async {
              if (count_field == "" ||
                  prices == "" ||
                  formattedDate == "" ||
                  image1 == "" ||
                  image2 == "" ||
                  (isChecked_box1 == false &&
                      isChecked_box2 == false &&
                      isChecked_box3 == false &&
                      isChecked_box4 == false &&
                      isChecked_box5 == false &&
                      isChecked_box6 == false)) {
                dialong(context, "กรุณากรอกข้อมูลและแนปรูปภาพ");
              } else {
                if (isChecked_box1 == true) {
                  total_choice.add("พริก");
                }
                if (isChecked_box2 == true) {
                  total_choice.add("ข้าวโพด");
                }
                if (isChecked_box3 == true) {
                  total_choice.add("มันสำปะหลัง");
                }
                if (isChecked_box4 == true) {
                  total_choice.add("อ้อย");
                }
                if (isChecked_box5 == true) {
                  total_choice.add("พริก");
                }

                if (isChecked_box6 == true) {
                  total_choice.add("อื่นๆ");
                }

                SharedPreferences preferences =
                    await SharedPreferences.getInstance();

                preferences.setString("count_field", count_field);
                preferences.setString("prices", prices);
                preferences.setString("info_choice", info_choice);
                preferences.setString("date_work", formattedDate);
                preferences.setString("details", details);
                preferences.setString("img1", image1);
                preferences.setString("img2", image2);
                preferences.setString("box1", isChecked_box1.toString());
                preferences.setString("box2", isChecked_box2.toString());
                preferences.setString("box3", isChecked_box3.toString());
                preferences.setString("box4", isChecked_box4.toString());
                preferences.setString("box5", isChecked_box5.toString());
                preferences.setString("box6", isChecked_box6.toString());
                preferences.setString("total_choice", total_choice.toString());

                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Setmap_presentwork_labor());
                Navigator.push(context, route);
              }
            },
            child: Text("ถัดไป",
                style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget type_car() => Container(
      height: 60,
      width: 200,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type_presentwork = value.trim(),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            hintText: type_presentwork,
            fillColor: Colors.white70),
      ));

  Widget b_count_field() => Container(
        height: 60,
        width: 200,
        child: TextField(
          onChanged: (value) => count_field = value.trim(),
          decoration: InputDecoration(
            hintText: "จำนวนไร่",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget prieces() => Container(
        height: 60,
        width: 200,
        child: TextField(
          onChanged: (value) => prices = value.trim(),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "ราคา",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget more_details() => Container(
        height: 60,
        width: 200,
        child: TextField(
          onChanged: (value) => details = value.trim(),
          decoration: InputDecoration(
            hintText: "รายละเอียด",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
          maxLines: 5,
          minLines: 1,
        ),
      );

  Widget choice() => Container(
        height: 60,
        width: 200,
        child: TextField(
          controller: fieldText,
          readOnly: check_choice,
          onChanged: (value) => info_choice = value.trim(),
          decoration: InputDecoration(
            hintText: "เพิ่มข้อมูลอื่นๆ",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
          maxLines: 5,
          minLines: 1,
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
                icon: Image.file(img1),
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
                icon: Image.file(img2),
              ),
      );

  Widget box1() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ข้าว", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box1,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box1 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box2() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ข้าวโพด", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box2,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box2 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box3() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("มันสำปะหลัง", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box3,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box3 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box4() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("อ้อย", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box4,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box4 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box5() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("พริก", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box5,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box5 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box6() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("อื่นๆ", style: GoogleFonts.mitr(fontSize: 18)),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box6,
          onChanged: (bool? value) {
            setState(() {
              check_choice = !check_choice;
              isChecked_box6 = value!;
              if (check_choice == true) {
                fieldText.clear();
              }
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
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
            labelText: "เลือกวันที่เริ่มงาน",
            labelStyle: GoogleFonts.mitr(fontSize: 18), //label text of field
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
