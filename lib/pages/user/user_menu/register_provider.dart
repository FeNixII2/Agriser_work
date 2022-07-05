import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register_provider extends StatefulWidget {
  const Register_provider({Key? key}) : super(key: key);

  @override
  State<Register_provider> createState() => _Register_providerState();
}

class _Register_providerState extends State<Register_provider> {
  late String name_p = "";
  late String tel_p = "";
  late String pass = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name_p = preferences.getString('name')!;
      tel_p = preferences.getString('tel')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ลงทะเบียน"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Allmethod().Showlogo(),
              Allmethod().Space(),
              Allmethod().Space(),
              Telform(),
              Allmethod().Space(),
              // Passwordform(),
              // Allmethod().Space(),
              Nameform(),
              Allmethod().Space(),
              Comfirmbutton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Comfirmbutton() => Container(
        width: 300.0,
        child: RaisedButton(
          color: Allmethod().dartcolor,
          onPressed: () {
            Alertlogout();
          },
          child: Text(
            "ยืนยันการลงทะเบียน",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  void checktelprovider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/getProviderWhereUser.php?isAdd=true&tel_p=$tel_p");
    print(response.data);
    if (response.data == "null") {
      registhread();
    } else {
      Navigator.of(context).pop();
      dialong(context, "คุณได้สมัครผู้ให้บริการไปแล้ว");
    }
  }

  void registhread() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/addProvider.php?isAdd=true&tel_p=$tel_p&name_p=$name_p");
    print(response.data);
    if (response.data == "true") {
      // MaterialPageRoute route =
      //     MaterialPageRoute(builder: (value) => All_bottombar_provider());
      // Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  Widget Nameform() => Container(
        width: 300.0,
        child: TextField(
          enabled: false,
          onChanged: (value) => name_p = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Allmethod().dartcolor),
            labelText: "$name_p",
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
          enabled: false,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          onChanged: (value) => tel_p = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelStyle: TextStyle(color: Allmethod().dartcolor),
            labelText: "$tel_p",
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
          onChanged: (value) => pass = value.trim(),
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

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ลงทะเบียนผู้ให้บริการ'),
            content: Text(
              'เมื่อคุณลงทะเบียนผู้ให้บริการ จะสามารถเข้าใช้ฟังก์ชั่นผู้ให้บริการได้เพื่อทำการติดต่อกับผู้ใช้ทั่วไป',
            ),
            actions: <Widget>[cancelButton(), okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('ยืนยัน'),
      onPressed: () {
        checktelprovider();
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('ยกเลิก'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
