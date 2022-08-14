import 'package:agriser_work/pages/provider/provider_service/add_provider_service.dart';
import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/add_user_presentwork.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        title: Text("เลือกประเภทจ้างงาน"),
        backgroundColor: Colors.green.shade400,
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
                          builder: (context) => Add_user_presentwork());
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
                          builder: (context) => Add_user_presentwork());
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
