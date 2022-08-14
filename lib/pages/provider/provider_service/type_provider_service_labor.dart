import 'package:agriser_work/pages/provider/provider_service/add_provider_service.dart';
import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utility/allmethod.dart';

class Type_provider_service_labor extends StatefulWidget {
  const Type_provider_service_labor({Key? key}) : super(key: key);

  @override
  State<Type_provider_service_labor> createState() =>
      _Type_provider_service_laborState();
}

class _Type_provider_service_laborState
    extends State<Type_provider_service_labor> {
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
        title: Text("เลือกประเภทงานให้บริการ"),
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Space(),
            Allmethod().Space(),
            Text("แรงงานทางการเกษตร"),
            Allmethod().Space(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  child: RaisedButton(
                    child: Text("เพาะปลูก"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString("choose_type_service", "เพาะปลูก");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service_labor());
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
                    child: Text("เก็บเกี่ยว"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString(
                          "choose_type_service", "เก็บเกี่ยว");
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => Add_provider_service_labor());
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
