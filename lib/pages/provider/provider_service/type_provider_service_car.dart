import 'package:agriser_work/pages/provider/provider_service/add_provider_service.dart';
import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utility/allmethod.dart';

class Type_provider_service_car extends StatefulWidget {
  const Type_provider_service_car({Key? key}) : super(key: key);

  @override
  State<Type_provider_service_car> createState() =>
      _Type_provider_service_carState();
}

class _Type_provider_service_carState extends State<Type_provider_service_car> {
  late String select_type_service;

  @override
  void initState() {
    super.initState();
    getpermission();
  }

  getpermission() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      select_type_service = preferences.getString("select_type_service")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("เลือกประเภทงานให้บริการ"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Space(),
            Text("รถทางการเกษตร"),
            Allmethod().Space(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: RaisedButton(
                    child: Text("รถเกี่ยวข้าว"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          "choose_type_service", "รถเกี่ยวข้าว");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service());
                      Navigator.push(context, route);
                    },
                  ),
                ),
                Allmethod().Space(),
                Allmethod().Space(),
                Allmethod().Space(),
                Allmethod().Space(),
                Container(
                  width: 140,
                  height: 140,
                  child: RaisedButton(
                    child: Text(
                      "รถแทรกเตอร์",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          "choose_type_service", "รถแทรกเตอร์");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service());
                      Navigator.push(context, route);
                    },
                  ),
                ),
              ],
            ),
            Allmethod().Space(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: RaisedButton(
                    child: Text("รถขนข้าว"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString("choose_type_service", "รถขนข้าว");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service());
                      Navigator.push(context, route);
                    },
                  ),
                ),
                Allmethod().Space(),
                Allmethod().Space(),
                Allmethod().Space(),
                Allmethod().Space(),
                Container(
                  width: 140,
                  height: 140,
                  child: RaisedButton(
                    child: Text("โดรน"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString("choose_type_service", "โดรน");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service());
                      Navigator.push(context, route);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
