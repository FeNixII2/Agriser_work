import 'package:agriser_work/pages/user/contact/user_both_contact.dart';
import 'package:agriser_work/pages/user/request/user_both_request.dart';
import 'package:agriser_work/utility/allmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class User_calenda extends StatefulWidget {
  const User_calenda({Key? key}) : super(key: key);

  @override
  State<User_calenda> createState() => _User_calendaState();
}

class _User_calendaState extends State<User_calenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [tractor(), user()],
      ),
    ));
  }

  Widget tractor() => Container(
        padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
        height: 580,
        width: 170,
        child: Material(
          color: Color.fromARGB(227, 255, 251, 177),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (value) => User_both_contact());
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
                Text('บริการ', style: GoogleFonts.mitr(fontSize: 18)),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget user() => Container(
        padding: EdgeInsets.fromLTRB(0, 10, 10, 5),
        height: 580,
        width: 170,
        child: Material(
          color: Color.fromARGB(255, 184, 252, 186),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (value) => User_both_request());
              Navigator.push(context, route);
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
                Text('งานประกาศ', style: GoogleFonts.mitr(fontSize: 18)),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
}
