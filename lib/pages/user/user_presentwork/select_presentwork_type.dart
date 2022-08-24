import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_labor.dart';
import 'package:agriser_work/pages/user/all_bottombar_user.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_labor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Select_presentwork_type extends StatefulWidget {
  const Select_presentwork_type({Key? key}) : super(key: key);

  @override
  State<Select_presentwork_type> createState() =>
      _Select_presentwork_typeState();
}

class _Select_presentwork_typeState extends State<Select_presentwork_type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade400,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => All_bottombar_user()),
            ),
          ),
          title: Text(
            "เลือกประเภทประกาศจ้างงาน",
            style: GoogleFonts.mitr(
              fontSize: 18,
            ),
          ),
        ),
        body: Column(
          children: [car(), labor()],
        ));
  }

  Widget car() => Container(
        padding: EdgeInsets.all(20),
        height: 320,
        width: 400,
        child: Material(
          color: Color.fromARGB(227, 255, 251, 177),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("select_type_service", "car");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => List_user_presentwork_car());
              Navigator.push(context, route);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/tractor_cld.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถทางการเกษตร',
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

  Widget labor() => Container(
        padding: EdgeInsets.all(20),
        height: 320,
        width: 400,
        child: Material(
          color: Color.fromARGB(255, 184, 252, 186),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("select_type_service", "labor");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => List_user_presentwork_labor(),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/farmer_cld.png"),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แรงงานทางการเกษตร',
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
