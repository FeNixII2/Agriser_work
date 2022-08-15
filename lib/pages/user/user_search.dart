import 'dart:convert';

// import 'package:agriser_work/pages/user/user_menu/list_service.dart';
import 'package:agriser_work/pages/user/user_menu/list_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/usermodel.dart';
import '../../utility/allmethod.dart';
import '../../utility/dialog.dart';

class User_search extends StatefulWidget {
  const User_search({Key? key}) : super(key: key);

  @override
  State<User_search> createState() => _User_searchState();
}

class _User_searchState extends State<User_search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Allmethod().Space(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageButton1(),
                    Allmethod().Space(),
                    ImageButton2(),
                  ]),
              Allmethod().Space(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageButton3(),
                    Allmethod().Space(),
                    ImageButton4(),
                  ]),
              Allmethod().Space(),
              ImageButton5()
            ],
          ),
        ),
      ),
    );
  }

  Widget ImageButton1() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: (() => search_1()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถเกี่ยวข้าว',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  void search_1() async {
    print("เข้าหารถเกียวข้าว");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("function", "1");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => List_service());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget ImageButton2() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: ((() => search_2())),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถไถนา',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  void search_2() async {
    print("เข้าหารถไถนา");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("function", "2");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => List_service());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget ImageButton3() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: ((() => search_3())),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถปลูกข้าว',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  void search_3() async {
    print("เข้าหารถเกียวข้าว");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("function", "3");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => List_service());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget ImageButton4() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: ((() => search_4())),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'โดรน',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  void search_4() async {
    print("เข้าหาโดรน");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("function", "4");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => List_service());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget ImageButton5() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: ((() => search_5())),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แรงงานทางการเกษตร',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  void search_5() async {
    print("แรงงานทางการเกษตร");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("function", "5");
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => List_service());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
