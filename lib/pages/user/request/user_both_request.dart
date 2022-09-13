import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/request/user_record_request.dart';
import 'package:agriser_work/pages/user/request/user_schedule_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class User_both_request extends StatefulWidget {
  const User_both_request({Key? key}) : super(key: key);

  @override
  State<User_both_request> createState() => _User_both_requestState();
}

class _User_both_requestState extends State<User_both_request> {
  int _currenIndex_C = 0;

  final List<Widget> _children_c = [
    User_schedule_request(),
    User_record_request(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex_C = index;
    });
  }

  asd() {
    return Text("sadsad", style: GoogleFonts.mitr(fontSize: 18));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              title: Text("ตารางงานที่ร้องขอเข้ามา",
                  style: GoogleFonts.mitr(fontSize: 18)),
              backgroundColor: Colors.green.shade400,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => All_bottombar_user()),
                ),
              )),
          // body: _children[_currenIndex],,

          body: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: Text("รอดำเนินการ",
                        style: GoogleFonts.mitr(fontSize: 18)),
                  ),
                  Tab(
                    child:
                        Text("ประวัติ", style: GoogleFonts.mitr(fontSize: 18)),
                  )
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  User_schedule_request(),
                  User_record_request(),
                ]),
              ),
            ],
          )),
    );
  }
}
