import 'package:agriser_work/login.dart';
import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/user/user_calenda.dart';
import 'package:agriser_work/pages/user/user_chat.dart';
import 'package:agriser_work/pages/user/user_main.dart';
import 'package:agriser_work/pages/user/user_menu/register_provider.dart';
import 'package:agriser_work/pages/user/user_search.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class All_bottombar_user extends StatefulWidget {
  const All_bottombar_user({Key? key}) : super(key: key);

  @override
  State<All_bottombar_user> createState() => _All_bottombar_userState();
}

class _All_bottombar_userState extends State<All_bottombar_user> {
  late String name_user;
  late String phone_user;
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
      name_user = preferences.getString('name_user')!;
      phone_user = preferences.getString('phone_user')!;
      name_provider = preferences.getString('name_user')!;
      phone_provider = preferences.getString('phone_user')!;
      preferences.setString("phone_provider", phone_provider);
      preferences.setString("name_provider", name_provider);
      print("------------ User - Mode ------------");
      print("--- Get name user State :     " + name_user);
      print("--- Get phone user State :     " + phone_user);
    });
  }

  Future<Null> checklogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
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
                  backgroundColor: Colors.amber,
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

  //////////////////////////////////////////////////////////////////////////////////////////////

  Drawer drawer() => Drawer(
        // backgroundColor: Colors.green.shade400,
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
        color: Colors.green.shade400,
      ),
      accountName: Text(name_user == null ? 'Main User' : "$name_user"),
      accountEmail: Text(phone_user == null ? 'Main Tel' : "$phone_user"),
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
        title: Text("ผู้ให้บริการ"),
        onTap: () {
          check_data_provider();
        },
      );

  ListTile Logout() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("ออกจากระบบ"),
        onTap: () {
          Alertlogout();
        },
      );

  void check_data_provider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/getProviderWhereUser.php?isAdd=true&phone_provider=$phone_provider");
    print(response.data);
    if (response.data == "null") {
      Alert_regis_provider();
    } else {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
    }
  }

  void regis_provider() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/addProvider.php?isAdd=true&phone_provider=$phone_provider&name_provider=$name_provider");
    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (value) => All_bottombar_provider());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

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

  void Alert_regis_provider() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คุณยังไม่มีบัญชีผู้ให้บริการ!'),
            content: Text(
              'เมื่อคุณลงทะเบียนผู้ให้บริการ จะสามารถเข้าใช้ฟังก์ชั่นผู้ให้บริการได้เพื่อทำการติดต่อกับผู้ใช้ทั่วไป คุณต้องการลงทะเบียนต่อหรือไม่',
            ),
            actions: <Widget>[cancelButton(), okButton_change_mode()],
          );
        });
  }

  Widget okButton_change_mode() {
    return FlatButton(
      child: Text('ตกลง'),
      onPressed: () {
        regis_provider();
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => All_bottombar_provider());
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      },
    );
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
