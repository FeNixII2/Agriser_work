// import 'package:agriser_work/utility/allmethod.dart';
// import 'package:agriser_work/utility/dialog.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'login.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   late String name_user = "";
//   late String phone_user = "";
//   late String password_user = "";
//   late String email_user = "";
//   late String date_user = "";
//   late String sex_user = "";
//   late String address_user = "";
//   late String province_user = "";
//   late String district_user = "";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ลงทะเบียน"),
//         backgroundColor: Allmethod().dartcolor,
//       ),
//       body: Container(
//         padding: EdgeInsets.fromLTRB(45, 20, 0, 0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Allmethod().Showlogo(),
//               Allmethod().Space(),
//               Telform(),
//               Allmethod().Space(),
//               Passwordform(),
//               Allmethod().Space(),
//               Nameform(),
//               Allmethod().Space(),
//               Emailform(),
//               Allmethod().Space(),
//               Dateform(),
//               Allmethod().Space(),
//               Comfirmbutton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   //////////////////////////////////////////////////////////////////////

//   Widget Comfirmbutton() => Container(
//         width: 300.0,
//         child: RaisedButton(
//           color: Allmethod().dartcolor,
//           onPressed: () {
//             print("กดยืนยัน");
//             print(
//               "ชื่อ = $name_user, เบอร์โทร - $phone_user, รหัสผ่าน = $password_user",
//             );
//             if (phone_user == null ||
//                 phone_user.isEmpty ||
//                 name_user == null ||
//                 name_user.isEmpty ||
//                 password_user == null ||
//                 password_user.isEmpty) {
//               dialong(context, "กรุณากรอกข้อมูลให้ครบทุกช่อง");
//               print("กรอกข้อมูลไม่ครบ");
//             } else {
//               checktel();
//             }
//           },
//           child: Text(
//             "ยืนยัน",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );

//   void checktel() async {
//     var dio = Dio();
//     final response = await dio.get(
// <<<<<<< HEAD
//         "http://192.168.1.4/agriser_work/getUserWhereUser.php?isAdd=true&tel=$tel");
// =======
//         "http://192.168.1.3/agriser_work/getUserWhereUser.php?isAdd=true&tel=$phone_user");
// >>>>>>> 0559f4d7407e904e09bbcb293f09f1605609a00f
//     print(response.data);
//     if (response.data == "null") {
//       registhread();
//     } else {
//       dialong(context, "เบอร์ $phone_user ถูกใช้งานแล้ว กรุณาลองใหม่");
//     }
//   }

//   void registhread() async {
//     var dio = Dio();
//     final response = await dio.get(
// <<<<<<< HEAD
//         "http://192.168.1.4/agriser_work/addUser.php?isAdd=true&tel=$tel&pass=$pass&name=$name");
// =======
//         "http://192.168.1.3/agriser_work/addUser.php?isAdd=true&tel=$phone_user&pass=$password_user&name=$name_user");
// >>>>>>> 0559f4d7407e904e09bbcb293f09f1605609a00f
//     print(response.data);
//     if (response.data == "true") {
//       MaterialPageRoute route =
//           MaterialPageRoute(builder: (context) => Login());
//       Navigator.pushAndRemoveUntil(context, route, (route) => false);
//       dialong(context, "ลงทะเบียนสำเร็จ");
//     } else {
//       dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
//     }
//   }

//   Widget Nameform() => Container(
//         width: 300.0,
//         child: TextField(
//           onChanged: (value) => name_user = value.trim(),
//           decoration: InputDecoration(
//             prefixIcon: Icon(Icons.account_box),
//             labelStyle: TextStyle(color: Allmethod().dartcolor),
//             labelText: "ชื่อ-นามสกุล",
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//           ),
//         ),
//       );

//   Widget Telform() => Container(
//         width: 300.0,
//         child: TextField(
//           keyboardType: TextInputType.number,
//           textInputAction: TextInputAction.go,
//           onChanged: (value) => phone_user = value.trim(),
//           decoration: InputDecoration(
//             prefixIcon: Icon(Icons.account_box),
//             labelStyle: TextStyle(color: Allmethod().dartcolor),
//             labelText: "เบอร์โทรศัพท์",
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//           ),
//         ),
//       );

//   Widget Passwordform() => Container(
//         width: 300.0,
//         child: TextField(
//           obscureText: true,
//           onChanged: (value) => password_user = value.trim(),
//           decoration: InputDecoration(
//             prefixIcon: Icon(Icons.lock),
//             labelStyle: TextStyle(color: Allmethod().dartcolor),
//             labelText: "รหัสผ่าน",
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//           ),
//         ),
//       );

//   Widget Emailform() => Container(
//         width: 300.0,
//         child: TextField(
//           onChanged: (value) => email_user = value.trim(),
//           decoration: InputDecoration(
//             prefixIcon: Icon(Icons.account_box),
//             labelStyle: TextStyle(color: Allmethod().dartcolor),
//             labelText: "อีเมล",
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Allmethod().dartcolor)),
//           ),
//         ),
//       );

//   Widget Dateform() => Container(
//         width: 300.0,
//         child: TextFormField(),
//       );

//   Widget Sexform() => Container(
//         width: 300.0,
//         child: TextFormField(),
//       );

//   Widget Addressform() => Container(
//         width: 300.0,
//         child: TextFormField(),
//       );
//   Widget Provinceform() => Container(
//         width: 300.0,
//         child: TextFormField(),
//       );
//   Widget Destrictform() => Container(
//         width: 300.0,
//         child: TextFormField(),
//       );
// }
