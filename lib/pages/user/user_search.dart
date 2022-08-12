import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utility/allmethod.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              ImageButton5()
            ],
          ),
        ),
      ),
    );
  }

  Widget ImageButton1() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถเกี่ยวข้าว',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton2() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถไถนา',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton3() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'รถปลูกข้าว',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton4() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'โดรน',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );

  Widget ImageButton5() => Container(
        child: Material(
          color: Color.fromARGB(255, 152, 252, 156),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Ink.image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 6),
                Text(
                  'แรงงานทางการเกษตร',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
}

// child: InkWell(
//             onTap: () {},
//             child: Ink.image(
//               image: AssetImage("assets/images/logo.png"),
//               height: 200,
//               width: 200,
//               fit: BoxFit.cover,
//               child: Text(
//                 'Button',
//                 style: TextStyle(fontSize: 22, color: Colors.green),
//               ),
//             ),
//           ),
