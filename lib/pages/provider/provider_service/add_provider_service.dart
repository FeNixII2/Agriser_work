import 'dart:io';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utility/allmethod.dart';

class Add_provider_service extends StatefulWidget {
  const Add_provider_service({Key? key}) : super(key: key);

  @override
  State<Add_provider_service> createState() => _Add_provider_serviceState();
}

class _Add_provider_serviceState extends State<Add_provider_service> {
  late File _image_car;
  late File _image_license;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  bool check1 = false;
  bool check2 = false;
  String type = "";
  String brand = "";
  String model = "";
  String date_buy = "";
  String prices = "";
  String image_car = "";
  String image_license_plate = "";

  String email_provider = "";
  String address_provider = "";
  String province_provider = "";
  String district_provider = "";
  String map_lat_provider = "";
  String map_long_provider = "";

  late String name_provider;
  late String phone_provider;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString("choose_type_service")!;

      phone_provider = preferences.getString('phone_user')!;
      name_provider = preferences.getString('name_provider')!;
      email_provider = preferences.getString('email_provider')!;
      address_provider = preferences.getString('address_provider')!;
      province_provider = preferences.getString('province_provider')!;
      district_provider = preferences.getString('district_provider')!;
      map_lat_provider = preferences.getString('map_lat_provider')!;
      map_long_provider = preferences.getString('map_long_provider')!;

      print("------------ Provider - Mode ------------");
      print("--- Get type provider State :     " + type);

      print("--- Get phone provider State :     " + phone_provider);
      print("--- Get name_provider State :     " + name_provider);
      print("--- Get email_provider State :     " + email_provider);
      print("--- Get address_provider State :     " + address_provider);
      print("--- Get province_provider State :     " + province_provider);
      print("--- Get district_provider State :     " + district_provider);
      print("--- Get map_lat_provider State :     " + map_lat_provider);
      print("--- Get map_long_provider State :     " + map_long_provider);
    });
  }

  Future chooseImage1() async {
    var pickImage1 = await picker1.getImage(source: ImageSource.gallery);
    setState(() {
      _image_car = File(pickImage1!.path);
      check1 = true;
      // print("Path File :      " + _image.path);
    });
  }

  Future chooseImage2() async {
    var pickImage2 = await picker2.getImage(source: ImageSource.gallery);
    setState(() {
      _image_license = File(pickImage2!.path);
      check2 = true;
      // print("Path File :      " + _image.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.1.4/agriser_work/up_img_p.php");

    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_provider"] = phone_provider;
    var pic_car =
        await http.MultipartFile.fromPath("image_car", _image_car.path);
    var pic_license =
        await http.MultipartFile.fromPath("image_license", _image_license.path);
    // var id_pro = await http.MultipartFile.fromPath("id_pro", "111");
    request.files.add(pic_car);
    request.files.add(pic_license);
    var response = await request.send();

    if (response.statusCode == 200) {
      regisservice();
      print("Image UPLOAD");
    } else {
      print("UPLOAD FAIL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดให้บริการ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Allmethod().Space(),
            type_car(),
            Allmethod().Space(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [w_brand(), SizedBox(width: 1), w_model()],
            ),
            Allmethod().Space(),
            w_date_buy(),
            Allmethod().Space(),
            w_price_per_rai(),
            Allmethod().Space(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/images/img_front.png")),
                SizedBox(width: 1),
                display_image_car(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/images/img_left.png")),
                SizedBox(width: 1),
                display_image_license_plate(),
              ],
            ),
            Container(
              width: 380,
              height: 50,
              child: RaisedButton(
                  child: Text("อัพโหลด"),
                  onPressed: () {
                    uploadImage();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget type_car() => Container(
      width: 300.0,
      child: TextField(
        readOnly: true,
        onChanged: (value) => type = value.trim(),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.time_to_leave),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: type,
            fillColor: Colors.white70),
      ));

  Widget w_brand() => Container(
        width: 150.0,
        child: TextField(
          onChanged: (value) => brand = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.abc),
            hintText: "ยี่ห้อ",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget w_model() => Container(
        width: 150.0,
        child: TextField(
          onChanged: (value) => model = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.developer_mode_outlined),
            hintText: "รุ่นรถ",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget w_date_buy() => Container(
        width: 300.0,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => date_buy = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.timer),
            hintText: "ปีพ.ศ.ที่ซื้อ ตัวอย่าง 2560",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget w_price_per_rai() => Container(
        width: 300.0,
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => prices = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.price_change_rounded),
            hintText: "ราคา/ไร่ ตัวอย่าง 800",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
        ),
      );

  Widget w_pickimg() => Container(
        child: IconButton(
          icon: Icon(Icons.camera),
          onPressed: () {
            chooseImage1();
          },
        ),
      );

  Widget display_image_car() => Container(
        // child: check1 == false ? Text('No Image') : Image.file(_image_car),
        // width: 250,
        // height: 250,
        // color: Colors.red,
        child: check1 == false
            ? IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage1();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage1();
                },
                icon: Image.file(_image_car),
              ),
      );

  Widget display_image_license_plate() => Container(
        child: check2 == false
            ? IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage2();
                },
                color: Color.fromARGB(255, 242, 238, 238),
                icon: Image.asset("assets/images/gallery.png"),
              )
            : IconButton(
                iconSize: 160,
                onPressed: () {
                  chooseImage2();
                },
                icon: Image.file(_image_license),
              ),
      );

  void regisservice() async {
    var dio = Dio();
    final response = await dio.get(
        "http://192.168.1.4/agriser_work/add_service_car.php?isAdd=true&type=$type&brand=$brand&model=$model&date_buy=$date_buy&prices=$prices&phone_provider=$phone_provider&name_provider=$name_provider&email_provider=$email_provider&address_provider=$address_provider&province_provider=$province_provider&district_provider=$district_provider&map_lat_provider=$map_lat_provider&map_long_provider=$map_long_provider");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => List_provider_service_car());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }
}
