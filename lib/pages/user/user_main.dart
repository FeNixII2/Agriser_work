import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/select_presentwork_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class User_main extends StatefulWidget {
  const User_main({Key? key}) : super(key: key);

  @override
  State<User_main> createState() => _User_mainState();
}

class _User_mainState extends State<User_main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            // color: Color.fromARGB(255, 184, 252, 186),
            onPressed: () async {
              print("คลิกเพิ่มประกาศจ้างงาน");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => Select_presentwork_type());
              Navigator.push(context, route);
            },
            child: Text("เพิ่มประกาศจ้างงาน",
                style: GoogleFonts.mitr(fontSize: 18)),
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
