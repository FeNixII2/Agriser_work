import 'package:agriser_work/pages/user/user_calenda.dart';
import 'package:agriser_work/pages/user/user_chat.dart';
import 'package:agriser_work/pages/user/user_main.dart';
import 'package:agriser_work/pages/user/user_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class All_bottombar_user extends StatefulWidget {
  const All_bottombar_user({Key? key}) : super(key: key);

  @override
  State<All_bottombar_user> createState() => _All_bottombar_userState();
}

int _currenIndex = 0;
final List<Widget> _children = [
  User_main(),
  User_search(),
  User_calenda(),
  User_chat()
];

void dd(int index) {
  setState() {
    _currenIndex = index;
  }
}

class _All_bottombar_userState extends State<All_bottombar_user> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: _children[_currenIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.green,
          ),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: dd,
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
}

Drawer drawer() => Drawer(
      child: ListView(
        children: [
          // Showdata(),
          // edituser(),
          // mode(),
          // regis_p(),
          // logout(),
        ],
      ),
    );
