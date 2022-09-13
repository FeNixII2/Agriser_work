import 'dart:convert';
import 'dart:io';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_labor.dart';
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

class Add_provider_service_labor extends StatefulWidget {
  const Add_provider_service_labor({Key? key}) : super(key: key);

  @override
  State<Add_provider_service_labor> createState() =>
      _Add_provider_service_laborState();
}

class _Add_provider_service_laborState
    extends State<Add_provider_service_labor> {
  late File img1;
  late File img2;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check_choice = true;
  bool check1 = false;
  bool check2 = false;
  List total_choice = [];
  late String phone_provider,
      type,
      info_choice = "ไม่มี",
      prices = "",
      image1 = "",
      image2 = "",
      rice,
      sweetcorn,
      cassava,
      sugarcane,
      chili,
      choice;
  final fieldText = TextEditingController();
  bool isChecked_box1 = false;
  bool isChecked_box2 = false;
  bool isChecked_box3 = false;
  bool isChecked_box4 = false;
  bool isChecked_box5 = false;
  bool isChecked_box6 = false;

  @override
  void initState() {
    super.initState();
    init();
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

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString("choose_type_service")!;

      phone_provider = preferences.getString('phone_user')!;

      print("------------ Provider - Mode ------------");
      print("--- Get type provider State :     " + type);

      print("--- Get phone provider State :     " + phone_provider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายละเอียดให้บริการ",
          style: GoogleFonts.mitr(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
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
                  type_labor(),
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
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ข้อมูลเพิ่มเติม :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_info_choice(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("ราคาต่อวัน :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  box_prices(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปประกอบที่1 :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  display1(),
                ],
              ),
              Allmethod().Space(),
              Row(
                children: [
                  Container(
                      width: 150,
                      child: Text("รูปประกอบที่2 :",
                          style: GoogleFonts.mitr(fontSize: 18))),
                  display2(),
                ],
              ),
              Allmethod().Space(),
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
                if (prices == "" ||
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

  Widget type_labor() => Container(
      height: 60,
      width: 200,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type = value.trim(),
        style: GoogleFonts.mitr(fontSize: 18),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: type,
            fillColor: Colors.white70),
      ));

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

  Widget box_prices() => Container(
        height: 60,
        width: 200,
        child: TextField(
          keyboardType: TextInputType.number,
          style: GoogleFonts.mitr(fontSize: 18),
          onChanged: (value) => prices = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง 800",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget box_info_choice() => Container(
        height: 60,
        width: 200,
        child: TextField(
          controller: fieldText,
          readOnly: check_choice,
          onChanged: (value) => info_choice = value.trim(),
          style: GoogleFonts.mitr(fontSize: 18),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง ผักชี,ลำไย",
            hintStyle: GoogleFonts.mitr(fontSize: 18),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
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
        if (isChecked_box1 == true) {
          total_choice.add("ข้าว");
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
        upload_service_labor();
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

  Future upload_service_labor() async {
    final uri =
        Uri.parse("http://192.168.1.4/agriser_work/add_service_labor.php");
    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_provider"] = phone_provider;
    request.fields["type"] = type;
    request.fields["info_choice"] = info_choice;
    request.fields["prices"] = prices;
    request.fields["image1"] = image1;
    request.fields["image2"] = image2;
    request.fields["box1"] = isChecked_box1.toString();
    request.fields["box2"] = isChecked_box2.toString();
    request.fields["box3"] = isChecked_box3.toString();
    request.fields["box4"] = isChecked_box4.toString();
    request.fields["box5"] = isChecked_box5.toString();
    request.fields["box6"] = isChecked_box6.toString();
    request.fields["total_choice"] = total_choice.toString();

    var response = await request.send();

    if (response.statusCode == 200) {
      MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => List_provider_service_labor());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      print("UPLOAD");
      dialong(context, "ลงทะเบียนบริการสำเร็จ");
    } else {
      print("UPLOAD FAIL");
    }
  }
}
