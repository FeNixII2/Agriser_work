import 'dart:convert';

import 'package:agriser_work/login.dart';
import 'package:agriser_work/pages/provider/provider_calenda.dart';
import 'package:agriser_work/pages/provider/provider_chat.dart';
import 'package:agriser_work/pages/provider/provider_main.dart';
import 'package:agriser_work/pages/provider/provider_menu/edit_provider_data.dart';
import 'package:agriser_work/pages/provider/provider_search.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:agriser_work/utility/modelprovider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utility/modeluser.dart';

class All_bottombar_provider extends StatefulWidget {
  const All_bottombar_provider({Key? key}) : super(key: key);

  @override
  State<All_bottombar_provider> createState() => _All_bottombar_providerState();
}

class _All_bottombar_providerState extends State<All_bottombar_provider> {
  late String id_provider;
  late String phone_provider = "", phone_user;
  late String name_provider = "";
  late String email_provider = "",
      date_provider = "",
      sex_provider = "",
      address_provider = "",
      province_provider = "",
      district_provider = "",
      map_lat_provider = "",
      map_long_provider = "";

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      phone_provider = preferences.getString('phone_provider')!;

      print("------------ User - Mode ------------");
      // print("--- Get name user State :     " + name_user);
      print("--- Get phone provider State :     " + phone_provider);
    });

    getinfo_user();
  }

  Future getinfo_user() async {
    print("------------ Getinfo User ------------");
    var url =
        "http://103.212.181.47/agriser_work/getProviderWhereProvider.php?isAdd=true&phone_provider=$phone_provider";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var map in jsonData) {
        Modelprovider datauser = Modelprovider.fromJson(map);
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
    preferences.setString("phone_provider", phone_provider);
    preferences.setString("name_provider", name_provider);
    preferences.setString("email_provider", email_provider);
    preferences.setString("address_provider", address_provider);
    preferences.setString("province_provider", province_provider);
    preferences.setString("district_provider", district_provider);
    preferences.setString("map_lat_provider", map_lat_provider);
    preferences.setString("map_long_provider", map_long_provider);
  }

  int _currenIndex = 0;

  final List<Widget> _children = [
    Provider_main(),
    Provider_search(),
    Provider_calenda(),
    Provider_chat()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: _children[_currenIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(),
          child: BottomNavigationBar(
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
        ));
  }

  Drawer drawer() => Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 0.0),
          children: [
            Show_user_data(),
            Edit_user_data(),
            Chance_mode(),
            Logout(),
          ],
        ),
      );

  UserAccountsDrawerHeader Show_user_data() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      accountName: Text(name_provider == null ? 'Main User' : "$name_provider",
          style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
      accountEmail: Text(
          phone_provider == null ? 'Main Tel' : "$phone_provider",
          style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/user.png'),
      ),
    );
  }

  ListTile Edit_user_data() => ListTile(
        leading: Icon(Icons.personal_injury),
        title: Text("ข้อมูลส่วนตัว", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Edit_provider_data());
          Navigator.push(context, route);
        },
      );

  ListTile Chance_mode() => ListTile(
        leading: Icon(Icons.switch_account),
        title: Text("ผู้ใช้ทั่วไป", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          phone_user = preferences.getString('phone_provider')!;
          preferences.setString("phone_user", phone_user);

          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => All_bottombar_user());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );

  ListTile Logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ", style: GoogleFonts.mitr(fontSize: 18)),
        onTap: () {
          Alertlogout();
        },
      );

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ออกจากระบบ', style: GoogleFonts.mitr(fontSize: 20)),
            content: Text('คุณต้องการออกจากระบบใช่หรือไม่',
                style: GoogleFonts.mitr(fontSize: 18)),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Future<Null> checklogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    MaterialPageRoute route = MaterialPageRoute(builder: (value) => Login());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
