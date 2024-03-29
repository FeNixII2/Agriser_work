import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/contact/provider_record_contact.dart';
import 'package:agriser_work/pages/provider/contact/provider_schedule_contact.dart';
import 'package:agriser_work/pages/user/contact/user_record_contact.dart';
import 'package:agriser_work/pages/user/contact/user_schedule_contact.dart';
import 'package:agriser_work/pages/user/request/user_record_request.dart';
import 'package:agriser_work/pages/user/request/user_schedule_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class Provider_both_contact extends StatefulWidget {
  const Provider_both_contact({Key? key}) : super(key: key);

  @override
  State<Provider_both_contact> createState() => _Provider_both_contactState();
}

class _Provider_both_contactState extends State<Provider_both_contact> {
  int _currenIndex_C = 0;

  final List<Widget> _children_c = [
    Provider_record_contact(),
    Provider_schedule_contact(),
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
              title: Text("ตารางงานที่ติอต่อ",
                  style: GoogleFonts.mitr(fontSize: 18)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => All_bottombar_provider()),
                ),
              )),
          // body: _children[_currenIndex],

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
                  Provider_schedule_contact(),
                  Provider_record_contact(),
                ]),
              ),
            ],
          )),
    );
  }
}
