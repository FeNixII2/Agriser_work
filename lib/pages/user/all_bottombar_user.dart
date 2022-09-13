import 'dart:convert';
import 'dart:io';
import 'package:agriser_work/model/usermodel.dart';
import 'package:agriser_work/pages/user/user_menu/edit_user_data.dart';
import 'package:agriser_work/utility/modeluser.dart';

import 'package:agriser_work/login.dart';
import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/user/user_calenda.dart';
import 'package:agriser_work/pages/user/user_chat.dart';
import 'package:agriser_work/pages/user/user_main.dart';
import 'package:agriser_work/pages/user/user_search.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class All_bottombar_user extends StatefulWidget {
  const All_bottombar_user({Key? key}) : super(key: key);

  @override
  State<All_bottombar_user> createState() => _All_bottombar_userState();
}

class _All_bottombar_userState extends State<All_bottombar_user> {
  late String name_user = "asdasd";
  late String phone_user = "";

  late String id_provider;
  var name_provider = "";
  late String phone_provider = "";
  late String email_provider = "",
      date_provider = "",
      sex_provider = "",
      address_provider = "",
      province_provider = "",
      district_provider = "",
      map_lat_provider = "",
      map_long_provider = "";

  List info_user = [];

  @override
  void initState() {
    super.initState();

    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      // name_user = preferences.getString('name_user')!;
      phone_user = preferences.getString('phone_user')!;
      
      // name_provider = preferences.getString('name_user')!;

      // preferences.setString("phone_provider", phone_provider);
      // preferences.setString("name_provider", name_provider);

      print("------------ User - Mode ------------");
      // print("--- Get name user State :     " + name_user);
      print("--- Get phone user State :     " + phone_user);
    });
    getinfo_user();
  }

  Future<Null> checklogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MaterialPageRoute route = MaterialPageRoute(builder: (value) => Login());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  int _currenIndex = 0;

  final List<Widget> _children = [
    User_main(),
    User_search(),
    User_calenda(),
    User_chat()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex = index;
    });
  }

  Future getinfo_user() async {
    print("------------ Getinfo User ------------");
    var url =
        "http://192.168.1.4/agriser_work/getUserWhereUser.php?isAdd=true&phone_user=$phone_user";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modeluser datauser = Modeluser.fromJson(map);
        setState(() {
          phone_provider = datauser.phone;
          name_provider = datauser.name;
          email_provider = datauser.email;
          date_provider = datauser.date;
          sex_provider = datauser.sex;
          address_provider = datauser.address;
          province_provider = datauser.province;
          district_provider = datauser.district;
          map_lat_provider = datauser.map_lat;
          map_long_provider = datauser.map_long;
        });

        // map_provider = datauser.map;

      }
    }

    print(phone_provider);
    print(name_provider);
    print(email_provider);
    print(date_provider);
    print(sex_provider);
    print(address_provider);
    print(province_provider);
    print(district_provider);
    print(map_lat_provider);
    print(map_long_provider);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name_user", name_user);
    preferences.setString("email_user", email_provider);
    preferences.setString("address_user", address_provider);
    preferences.setString("province_user", province_provider);
    preferences.setString("district_user", district_provider);
    preferences.setString("map_lat_user", map_lat_provider);
    preferences.setString("map_long_user", map_long_provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
      ),
      drawer: drawer(),
      body: _children[_currenIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(),
        child: BottomNavigationBar(
            fixedColor: Colors.green.shade400,
            // backgroundColor: Colors.amber,
            type: BottomNavigationBarType.fixed,
            onTap: onTappedBar,
            currentIndex: _currenIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'หน้าหลัก',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'ค้นหา',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'ตารางงาน',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: 'แชท',
              ),
            ]),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////

  Drawer drawer() => Drawer(
        // backgroundColor: Colors.green.shade400,
        child: ListView(
          padding: const EdgeInsets.only(top: 0.0),
          children: [
            Show_user_data(),
            Edit_user(),
            Chance_mode(),
            Logout(),
          ],
        ),
      );

  UserAccountsDrawerHeader Show_user_data() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.green.shade400,
      ),
      accountName: Text(name_user == null ? 'Main User' : "$name_provider",
          style: GoogleFonts.mitr(fontSize: 18)),
      accountEmail: Text(phone_user == null ? 'Main Tel' : "$phone_user",
          style: GoogleFonts.mitr(fontSize: 18)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
    );
  }

  ListTile Edit_user() => ListTile(
        leading: Icon(Icons.personal_injury),
        title: Text("ข้อมูลส่วนตัว", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Edit_user_data());
          Navigator.push(context, route);
        },
      );

  ListTile Chance_mode() => ListTile(
        leading: Icon(Icons.switch_account),
        title: Text("ผู้ให้บริการ", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () {
          check_data_provider();
        },
      );

  ListTile Logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () {
          Alertlogout();
        },
      );

  void check_data_provider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/getProviderWhereProvider.php?isAdd=true&phone_provider=$phone_provider");

    print(response.data);
    if (response.data == "null") {
      print("ไม่มีเบอร์นี้ในระบบผู้ให้บริการ");
      Alert_regis_provider();
    } else {
      print("มีเบอร์นี้ในระบบผู้ให้บริการ");
      SharedPreferences preferences = await SharedPreferences.getInstance();
      phone_provider = preferences.getString('phone_user')!;
      preferences.setString("phone_provider", phone_provider);

      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }

  void regis_provider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/addProvider.php?isAdd=true&phone_provider=$phone_provider&name_provider=$name_provider&email_provider=$email_provider&date_provider=$date_provider&sex_provider=$sex_provider&address_provider=$address_provider&province_provider=$province_provider&district_provider=$district_provider&map_lat_provider=$map_lat_provider&map_long_provider=$map_long_provider");

    print(response.data);
    if (response.data == "true") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      phone_provider = preferences.getString('phone_user')!;
      preferences.setString("phone_provider", phone_provider);
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  void Alert_regis_provider() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คุณยังไม่มีบัญชีผู้ให้บริการ!',
                style: GoogleFonts.mitr(fontSize: 18)),
            content: Text(
                'เมื่อคุณลงทะเบียนผู้ให้บริการ จะสามารถเข้าใช้ฟังก์ชั่นผู้ให้บริการได้เพื่อทำการติดต่อกับผู้ใช้ทั่วไป คุณต้องการลงทะเบียนต่อหรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_change_mode()],
          );
        });
  }

  Widget okButton_change_mode() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        regis_provider();
        // MaterialPageRoute route =
        //     MaterialPageRoute(builder: (value) => All_bottombar_provider());
        // Navigator.pushAndRemoveUntil(context, route, (route) => false);
      },
    );
  }

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ออกจากระบบ', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text('คุณต้องการออกจากระบบใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง', style: GoogleFonts.mitr(fontSize: 18)),
      onPressed: () {
        checklogout();
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
}
