import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/add_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/add_user_presentwork_labor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utility/allmethod.dart';

class Type_user_presentwork_labor extends StatefulWidget {
  const Type_user_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Type_user_presentwork_labor> createState() =>
      _Type_user_presentwork_laborState();
}

class _Type_user_presentwork_laborState
    extends State<Type_user_presentwork_labor> {
  @override
  void initState() {
    super.initState();
    getpermission();
  }

  getpermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เลือกประเภทจ้างงาน",
          style: GoogleFonts.mitr(
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Space(),
            Text(
              "แรงงานทางการเกษตร",
              style: GoogleFonts.mitr(
                fontSize: 18,
              ),
            ),
            Allmethod().Space(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ImageButton1(), Allmethod().Space(), ImageButton2()],
            ),
          ],
        ),
      ),
    );
  }

  Widget ImageButton1() => Container(
        padding: EdgeInsets.all(1),
        height: 175,
        width: 175,
        child: Material(
          color: Color.fromARGB(227, 255, 251, 177),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("choose_type_service", "เพาะปลูก");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_user_presentwork_labor());
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
                  'เพาะปลูก',
                  style: GoogleFonts.mitr(
                    fontSize: 18,
                  ),
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
          color: Color.fromARGB(227, 255, 251, 177),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("choose_type_service", "เก็บเกี่ยว");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_user_presentwork_labor());
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
                  'เก็บเกี่ยว',
                  style: GoogleFonts.mitr(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
}
