import 'dart:convert';

// import 'package:agriser_work/pages/user/user_menu/list_service.dart';
import 'package:agriser_work/pages/user/user_search/list_service.dart';
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
            children: <Widget>[
              Allmethod().Space(),
              Text(
                "รถทางการเกษตร",
                style: TextStyle(fontSize: 20),
              ),
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
              Text(
                "แรงงานทางการเกษตร",
                style: TextStyle(fontSize: 20),
              ),
              Allmethod().Space(),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageButton5(),
                    Allmethod().Space(),
                    ImageButton6(),
                  ]),
              Allmethod().Space(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ImageButton1() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "1");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i2.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถเกี่ยวข้าว',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton2() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "2");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i1.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แทรกเตอร์',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton3() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "3");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i3.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถดำนา',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton4() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "4");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i4.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'โดรน',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton5() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "5");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i5.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แรงงานเพาะปลูก',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton6() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(225, 255, 253, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("function", "6");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (context) => List_service());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/i6.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แรงงานเก็บเกี่ยว',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
}
