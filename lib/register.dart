import 'dart:convert';

import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'login.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String name_user = "";
  late String phone_user = "";
  late String password_user = "";
  late String email_user = "";
  late String date_user = "";
  late String sex_user = "";
  late String address_user = "";
  late String province_user = "";
  late String district_user = "";
  late String pickedDate = "";
  bool isChecked_b = false;
  bool isChecked_g = false;

  TextEditingController dateinput = TextEditingController();

  //// จังหวัด
  late String selectprovince;
  List data = [];

  Future getAllprovince() async {
    print("เข้าแล้วเน้อ");
    var dio = Dio();
    final response = await dio
        .get("http://192.168.1.3/Agriser_work/getProvince.php?isAdd=true");
    var result = json.decode(response.data);

    if (response.statusCode == 200) {
      setState(() {
        result = json.decode(response.data);
        data = result;
      });
      print(result);
      return result;
    }
    // return "success";
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
    getAllprovince();
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
        title: Text("ลงทะเบียน"),
        backgroundColor: Allmethod().dartcolor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Allmethod().Showlogo(),
              Allmethod().Space(),
              Telform(),
              Allmethod().Space(),
              Passwordform(),
              Allmethod().Space(),
              Nameform(),
              Allmethod().Space(),
              Emailform(),
              Allmethod().Space(),
              Addressform(),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'จังหวัด',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.orange),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Center(
              //   child: DropdownButton(
              //       value: selectprovince,
              //       hint: Text("Select Provines"),
              //       items: data.map((output) {
              //           return DropdownMenuItem(child: null);
              //         },),
              //       onChanged: (value) {
              //         setState(() {
              //           selectprovince = value;
              //         });
              //       }),
              // ),
              Allmethod().Space(),
              Comfirmbutton(),
            ],
          ),
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////

  Widget Comfirmbutton() => Container(
        width: 300.0,
        child: RaisedButton(
          color: Allmethod().dartcolor,
          onPressed: () {
            print("กดยืนยัน");
            print(
              "ชื่อ = $name_user, เบอร์โทร - $phone_user, รหัสผ่าน = $password_user",
            );
            if (phone_user == null ||
                phone_user.isEmpty ||
                name_user == null ||
                name_user.isEmpty ||
                password_user == null ||
                password_user.isEmpty) {
              dialong(context, "กรุณากรอกข้อมูลให้ครบทุกช่อง");
              print("กรอกข้อมูลไม่ครบ");
            } else {
              checktel();
            }
          },
          child: Text(
            "ยืนยัน",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  void checktel() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.3/agriser_work/getUserWhereUser.php?isAdd=true&tel=$phone_user");
    print(response.data);
    if (response.data == "null") {
      registhread();
    } else {
      dialong(context, "เบอร์ $phone_user ถูกใช้งานแล้ว กรุณาลองใหม่");
    }
  }

  void registhread() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.3/agriser_work/addUser.php?isAdd=true&tel=$phone_user&pass=$password_user&name=$name_user");
    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Login());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          onChanged: (value) => name_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Allmethod().dartcolor),
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
          textInputAction: TextInputAction.go,
          onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Allmethod().dartcolor),
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
            labelStyle: TextStyle(color: Allmethod().dartcolor),
            labelText: "รหัสผ่าน",
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
            labelStyle: TextStyle(color: Allmethod().dartcolor),
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
      height: 150,
      width: 300.0,
      child: TextField(
        controller: dateinput, //editing controller of this TextField
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date" //label text of field
            ),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          var dateTime = DateTime.now();
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: dateTime,
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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

  Widget Sexform_male() => Container(
        width: 140.0,
        child: CheckboxListTile(
          title: Text("Male"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_b,
          onChanged: (bool? value) {
            setState(() {
              isChecked_b = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget Sexform_frmale() => Container(
        width: 140.0,
        child: CheckboxListTile(
          title: Text("Female"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_g,
          onChanged: (bool? value) {
            setState(() {
              isChecked_g = value!;
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
            labelStyle: TextStyle(color: Allmethod().dartcolor),
            labelText: "ที่อยู่ปัจจุบัน",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Allmethod().dartcolor)),
          ),
        ),
      );
  Widget Provinceform() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'จังหวัด',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.orange),
          ),
        ),
      );

  Widget Destrictform() => Container(
        width: 300.0,
        child: TextFormField(),
      );
}
