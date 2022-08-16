import 'dart:io';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_labor.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utility/allmethod.dart';

class Add_provider_service_labor extends StatefulWidget {
  const Add_provider_service_labor({Key? key}) : super(key: key);

  @override
  State<Add_provider_service_labor> createState() =>
      _Add_provider_service_laborState();
}

class _Add_provider_service_laborState
    extends State<Add_provider_service_labor> {
  late File _image_car;
  late File _image_license;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check1 = false;
  bool check2 = false;
  String type = "";
  String brand = "";
  String model = "";
  String date_buy = "";
  String prices = "";
  String image_car = "";
  String image_license_plate = "";

  late String phone_provider;

  bool isChecked_box1 = false;
  bool isChecked_box2 = false;
  bool isChecked_box3 = false;
  bool isChecked_box4 = false;
  bool isChecked_box5 = false;
  bool isChecked_box6 = false;
  bool isChecked_box7 = false;
  bool isChecked_box8 = false;

  @override
  void initState() {
    super.initState();
    init();
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
        title: Text("รายละเอียดให้บริการ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Allmethod().Space(),
            type_labor(),
            Allmethod().Space(),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box7(), box8()],
            ),
            Allmethod().Space(),
            w_price_per_rai(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Allmethod().Space(),
            Container(
              width: 380,
              height: 50,
              child: RaisedButton(
                  child: Text("อัพโหลด"),
                  onPressed: () {
                    upload_service();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget type_labor() => Container(
      width: 300.0,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type = value.trim(),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.time_to_leave),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: type,
            fillColor: Colors.white70),
      ));

  Widget box1() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ข้าว"),
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
          title: Text("ข้าวโพด"),
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
          title: Text("มันสำปะหลัง"),
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
          title: Text("อ้อย"),
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
          title: Text("พริก"),
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
          title: Text("มันเทศ"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box6,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box6 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box7() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ปาล์ม"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box7,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box7 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box8() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ถั่ว"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box8,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box8 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget w_price_per_rai() => Container(
        width: 300.0,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => prices = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.price_change_rounded),
            hintText: "ราคาต่อวัน ตัวอย่าง 800",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  void upload_service() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/add_service_labor.php?isAdd=true&prices=$prices&phone_provider=$phone_provider&rice=$isChecked_box1&sweetcorn=$isChecked_box2&cassava=$isChecked_box3&sugarcane=$isChecked_box4&chili=$isChecked_box5&yam=$isChecked_box6&palm=$isChecked_box7&bean=$isChecked_box8&type=$type");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => List_provider_service_labor());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }
}
