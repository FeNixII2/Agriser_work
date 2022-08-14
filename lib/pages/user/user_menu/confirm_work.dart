import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../all_bottombar_user.dart';

class Confirm_work extends StatefulWidget {
  const Confirm_work({Key? key}) : super(key: key);

  @override
  State<Confirm_work> createState() => _Confirm_workState();
}

class _Confirm_workState extends State<Confirm_work> {
  List search_service = [];
  late String data_success;
  late String date_startwork;
  late String number_;
  late String name_user;
  late String name_provider;
  late String phone_provider;
  late String phone_user;
  late String type;
  late String price;
  late String formattedDate = "";
  int result = 0;
  late int price_all;
  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      date_startwork = preferences.getString('date_startwork')!;
      number_ = preferences.getString('number_')!;
      name_provider = preferences.getString('name_provider')!;
      phone_provider = preferences.getString('type')!;
      price = preferences.getString('price')!;
      name_user = preferences.getString('name_user')!;
      phone_user = preferences.getString('phone_user')!;
      price_all = int.parse(number_) * int.parse(price);
      print(price_all);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const All_bottombar_user()),
          ),
        ),
        title: Text("ยืนยันงาน"),
        // centerTitle: true,
      ),
      body: Column(
        children: [
          Text('งานเริ่มวันที่ $date_startwork'),
          Text('ราคาทั้งหมด $price_all บาท'),
          // แมพ
          RaisedButton(
            onPressed: () => submith(),
            child: Text("ยืนยันรายการ"),
          ),
        ],
      ),
    );
  }

  void submith() async {
    var url =
        "http://192.168.88.213/Agriser_work/confirm_work_user.php?isAdd=true";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        data_success = jsonData;
        // data = jsonData;
      });
      // MaterialPageRoute route =
      //     MaterialPageRoute(builder: (context) => Confirm_work());
      // Navigator.push(context, route);
      // print(int.parse(number_) * int.parse(price));
    }
  }
}
