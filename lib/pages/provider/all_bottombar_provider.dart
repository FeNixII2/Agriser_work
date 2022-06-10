import 'package:agriser_work/login.dart';
import 'package:agriser_work/pages/provider/provider_calenda.dart';
import 'package:agriser_work/pages/provider/provider_chat.dart';
import 'package:agriser_work/pages/provider/provider_main.dart';
import 'package:agriser_work/pages/provider/provider_search.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All_bottombar_provider extends StatefulWidget {
  const All_bottombar_provider({Key? key}) : super(key: key);

  @override
  State<All_bottombar_provider> createState() => _All_bottombar_providerState();
}

class _All_bottombar_providerState extends State<All_bottombar_provider> {
  late String name_provider;
  late String phone_provider;

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name_provider = preferences.getString('name_provider')!;
      phone_provider = preferences.getString('phone_provider')!;
      print("------------ Provider - Mode ------------");
      print("--- Get name provider State :     " + name_provider);
      print("--- Get phone provider State :     " + phone_provider);
    });
  }

  Future<Null> checklogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
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
      accountName: Text(name_provider == null ? 'Main User' : "$name_provider"),
      accountEmail:
          Text(phone_provider == null ? 'Main Tel' : "$phone_provider"),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        // backgroundImage: NetworkImage(gravatarUrl),
      ),
    );
  }

  ListTile Edit_user_data() => ListTile(
        leading: Icon(Icons.personal_injury),
        title: Text("ข้อมูลส่วนตัว"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => Edit_user_data());
          Navigator.push(context, route);
        },
      );

  ListTile Chance_mode() => ListTile(
        leading: Icon(Icons.switch_account),
        title: Text("ผู้ใช้ทั่วไป"),
        onTap: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => All_bottombar_user());
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );

  ListTile Logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),
        onTap: () {
          Alertlogout();
        },
      );

  void Alertlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ออกจากระบบ', style: GoogleFonts.mitr(fontSize: 22)),
            content: Text(
              'คุณต้องการออกจากระบบใช่หรือไม่',
            ),
            actions: <Widget>[cancelButton(), okButton_logout()],
          );
        });
  }

  Widget okButton_logout() {
    return FlatButton(
      child: Text('ตกลง'),
      onPressed: () {
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Login());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
