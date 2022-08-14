import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/provider/provider_service/select_provider_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Provider_main extends StatefulWidget {
  const Provider_main({Key? key}) : super(key: key);

  @override
  State<Provider_main> createState() => _Provider_mainState();
}

class _Provider_mainState extends State<Provider_main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            onPressed: () async {
              print("คลิกเพิ่มข้อมูลการให้บริการ");
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (value) => Select_provider_type());
              Navigator.push(context, route);
            },
            child: Text(
              "เพิ่มข้อมูลการให้บริการ",
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
