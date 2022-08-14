import 'package:agriser_work/pages/provider/provider_service/add_provider_service.dart';
import 'package:agriser_work/pages/provider/provider_service/add_provider_service_labor.dart';
import 'package:agriser_work/pages/user/user_presentwork/add_user_presentwork.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utility/allmethod.dart';

class Type_user_presentwork_car extends StatefulWidget {
  const Type_user_presentwork_car({Key? key}) : super(key: key);

  @override
  State<Type_user_presentwork_car> createState() =>
      _Type_user_presentwork_carState();
}

class _Type_user_presentwork_carState extends State<Type_user_presentwork_car> {
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
                          builder: (context) => Add_user_presentwork());
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
                    child: Text("โดรน"),
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString("choose_type_service", "โดรน");
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
