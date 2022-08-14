import 'package:agriser_work/pages/user/request/user_record_request.dart';
import 'package:agriser_work/pages/user/request/user_schedule_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Provider_both_request extends StatefulWidget {
  const Provider_both_request({Key? key}) : super(key: key);

  @override
  State<Provider_both_request> createState() => _Provider_both_requestState();
}

class _Provider_both_requestState extends State<Provider_both_request> {
  int _currenIndex_C = 0;

  final List<Widget> _children_c = [
    User_record_request(),
    User_schedule_request(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currenIndex_C = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("ตารางงานที่ร้องขอเข้ามา"),
            backgroundColor: Colors.green.shade400,
          ),
          // body: _children[_currenIndex],

          body: Column(
            children: [
              TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    text: "งานรอดำเนินการ",
                  ),
                  Tab(
                    text: "ประวัติ",
                  )
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  User_record_request(),
                  User_schedule_request(),
                ]),
              ),
            ],
          )),
    );
  }
}
