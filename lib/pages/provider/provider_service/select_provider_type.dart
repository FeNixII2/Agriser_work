import 'package:agriser_work/pages/provider/all_bottombar_provider.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_labor.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Select_provider_type extends StatefulWidget {
  const Select_provider_type({Key? key}) : super(key: key);

  @override
  State<Select_provider_type> createState() => _Select_provider_typeState();
}

class _Select_provider_typeState extends State<Select_provider_type> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => All_bottombar_provider()),
            ),
          ),
          title: Text("เลือกประเภทการให้บริการ"),
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
          color: Color.fromARGB(226, 238, 238, 230),
          elevation: 8,
          borderRadius: BorderRadius.circular(28),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString("select_type_service", "car");
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => List_provider_service_car());
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
                  style: TextStyle(fontSize: 22, color: Colors.black),
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
          color: Color.fromARGB(225, 255, 255, 244),
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
                  builder: (context) => List_provider_service_labor(),
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
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ),
      );
}
