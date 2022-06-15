import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../utility/allmethod.dart';

class Add_provider_service extends StatefulWidget {
  const Add_provider_service({Key? key}) : super(key: key);

  @override
  State<Add_provider_service> createState() => _Add_provider_serviceState();
}

class _Add_provider_serviceState extends State<Add_provider_service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Allmethod().Space(),
            type_car(),
            Allmethod().Space(),
            Row(
              children: [brand(), model()],
            ),
            Allmethod().Space(),
            date_buy(),
            Allmethod().Space(),
            price_per_rai(),
            Allmethod().Space(),
          ],
        ),
      ),
    );
  }

  Widget type_car() => Container(
      width: 300.0,
      child: TextField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey[800]),
            enabled: false,
            hintText: "ประเภทรถ",
            fillColor: Colors.white70),
      ));

  Widget brand() => Container(
        width: 150.0,
        child: TextField(
          // onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            hintText: "ยี่ห้อ",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget model() => Container(
        width: 150.0,
        child: TextField(
          // onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            hintText: "รุ่นรถ",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget date_buy() => Container(
        width: 300.0,
        child: TextField(
          // onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง 2560",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget price_per_rai() => Container(
        width: 300.0,
        child: TextField(
          // onChanged: (value) => phone_user = value.trim(),
          decoration: InputDecoration(
            hintText: "ตัวอย่าง 800",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget pickimg() => Container(
        child: IconButton(
          icon: Icon(Icons.camera),
          onPressed: () {},
        ),
      );
}
