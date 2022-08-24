import 'package:agriser_work/pages/provider/provider_service/add_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/add_user_presentwork_car.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utility/allmethod.dart';

class Type_provider_service_car extends StatefulWidget {
  const Type_provider_service_car({Key? key}) : super(key: key);

  @override
  State<Type_provider_service_car> createState() =>
      _Type_provider_service_carState();
}

class _Type_provider_service_carState extends State<Type_provider_service_car> {
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
        title: Text("เลือกประเภทจ้างงาน",
            style: GoogleFonts.mitr(fontSize: 18, color: Colors.white)),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Space(),
            Text(
              "รถทางการเกษตร",
              style: GoogleFonts.mitr(
                fontSize: 18,
              ),
            ),
            Allmethod().Space(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ImageButton1(), Allmethod().Space(), ImageButton2()],
            ),
            Allmethod().Space(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ImageButton3(), Allmethod().Space(), ImageButton4()],
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
              preferences.setString("choose_type_service", "รถเกี่ยวข้าว");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_provider_service_car());
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
              preferences.setString("choose_type_service", "รถแทรกเตอร์");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_provider_service_car());
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
                Container(
                  width: 120,
                  child: Text(
                    'รถแทรกเตอร์',
                    style: GoogleFonts.mitr(
                      fontSize: 18,
                    ),
                  ),
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
          color: Color.fromARGB(227, 255, 251, 177),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("choose_type_service", "รถดำนา");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_provider_service_car());
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
                  'รถดำนา',
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

  Widget ImageButton4() => Container(
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
              preferences.setString("choose_type_service", "โดรน");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => Add_provider_service_car());
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
