import 'dart:convert';

import 'package:agriser_work/model/usermodel.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/register.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String phone_user = "";
  late String password_user = "";
  bool _securetext = true;
  late String usernamelogin;

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  Future<Null> checklogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      usernamelogin = preferences.getString("name")!;
      print("usernamelogin = $usernamelogin");
      if (usernamelogin == null) {
        print("not login ready");
      } else {
        print("login ready");
        MaterialPageRoute route =
            MaterialPageRoute(builder: (context) => All_bottombar_user());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Allmethod().Showlogo(),
              Allmethod().Space(),
              Allmethod().Showapptext("Agriser App"),
              Allmethod().Space(),
              Userform(),
              Allmethod().Space(),
              Passwordform(),
              Loginbutton(),
              regisbutton()
            ],
          ),
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////

  Widget Loginbutton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Allmethod().dartcolor,
          onPressed: () {
            if (phone_user == null ||
                phone_user.isEmpty ||
                password_user == null ||
                password_user.isEmpty) {
              dialong(context, "กรุณากรอกให้ครบทุกช่อง");
            } else {
              checktel();
            }
          },
          child: Text(
            "เข้าสู่ระบบ",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Widget regisbutton() => Container(
        width: 250.0,
        child: RaisedButton(
          color: Allmethod().dartcolor,
          onPressed: () {
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => Register());
            Navigator.push(context, route);
          },
          child: Text(
            "ลงทะเบียน",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  void checktel() async {
    print("เช็คเบอร์");
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user");
    print("หาเบอร์แล้วเจอ:   " + response.data);
    if (response.data == "null") {
      dialong(context, "ไม่มีเบอร์ $phone_user ในระบบ");
    } else {
      print("1");
      var result = json.decode(response.data);
      print(result);
      print("2");
      // print("ได้ข้อมูลจากเบอร์:  " + result);
      for (var map in result) {
        Welcome datauser = Welcome.fromJson(map);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("phone_user", datauser.phone_user);
        preferences.setString("name_user", datauser.name_user);

        if (password_user == datauser.password_user) {
          print("ไปหน้าหลัก");
          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => All_bottombar_user());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
          print("เข้าสู่ระบบ");
        } else {
          dialong(context, "รหัสผ่านไม่ถูกต้อง");
        }
      }
    }
  }

  Widget Userform() => Container(
        width: 250.0,
        child: TextField(
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
        width: 250.0,
        child: TextField(
          obscureText: _securetext,
          onChanged: (value) => password_user = value.trim(),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(_securetext ? Icons.remove_red_eye : Icons.security),
              onPressed: () {
                setState(() {
                  _securetext = !_securetext;
                });
              },
            ),
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
}
