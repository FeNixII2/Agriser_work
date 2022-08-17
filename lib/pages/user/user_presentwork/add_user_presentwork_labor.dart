import 'dart:io';
import 'package:agriser_work/pages/provider/provider_service/list_provider_service_car.dart';
import 'package:agriser_work/pages/user/user_presentwork/list_user_presentwork_labor.dart';
import 'package:agriser_work/utility/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utility/allmethod.dart';

class Add_user_presentwork_labor extends StatefulWidget {
  const Add_user_presentwork_labor({Key? key}) : super(key: key);

  @override
  State<Add_user_presentwork_labor> createState() =>
      _Add_user_presentwork_laborState();
}

class _Add_user_presentwork_laborState
    extends State<Add_user_presentwork_labor> {
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
  String image_car_2 = "";

  late String name_provider;
  late String phone_user;
  late String map_lat_provider;
  late String map_long_provider;

  bool isChecked_box1 = false;
  bool isChecked_box2 = false;
  bool isChecked_box3 = false;
  bool isChecked_box4 = false;
  bool isChecked_box5 = false;
  bool isChecked_box6 = false;
  bool isChecked_box7 = false;
  bool isChecked_box8 = false;
  TextEditingController dateinput = TextEditingController();
  late String formattedDate = "";

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      type = preferences.getString("choose_type_service")!;

      phone_user = preferences.getString('phone_user')!;
      print("------------ Provider - Mode ------------");
      print("--- Get type provider State :     " + type);

      print("--- Get phone provider State :     " + phone_user);
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
    final uri = Uri.parse(
        "http://192.168.1.4/agriser_work/up_img_presentwork_labor.php");

    var request = http.MultipartRequest("POST", uri);
    request.fields["phone_user"] = phone_user;
    var pic_car =
        await http.MultipartFile.fromPath("img_field1", _image_car.path);
    var pic_license =
        await http.MultipartFile.fromPath("img_field2", _image_license.path);
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
        title: Text("รายละเอียดจ้างงาน"),
        backgroundColor: Colors.green.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Allmethod().Space(),
            type_car(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box1(), box2()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box3(), box4()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box5(), box6()],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [box7(), box8()],
            ),
            Allmethod().Space(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [w_brand(), SizedBox(width: 1), w_model()],
            ),
            Allmethod().Space(),
            Dateform(),
            Allmethod().Space(),
            w_price_per_rai(),
            Allmethod().Space(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/images/field.png")),
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
                    child: Image.asset("assets/images/field.png")),
                SizedBox(width: 1),
                display_image_car_2(),
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
            prefixIcon: Icon(Icons.type_specimen_outlined),
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
            hintText: "จำนวนไร่",
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
            hintText: "ราคา",
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
            hintText: "รายละเอียดเพิ่มเติม",
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
          ),
          maxLines: 5,
          minLines: 1,
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

  Widget display_image_car_2() => Container(
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
        "http://192.168.1.4/agriser_work/add_presentwork_labor.php?isAdd=true&type=$type&brand=$brand&model=$model&date_buy=$formattedDate&prices=$prices&phone_user=$phone_user&rice=$isChecked_box1&sweetcorn=$isChecked_box2&cassava=$isChecked_box3&sugarcane=$isChecked_box4&chili=$isChecked_box5&yam=$isChecked_box6&palm=$isChecked_box7&bean=$isChecked_box8");

    print(response.data);
    if (response.data == "true") {
      MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => List_user_presentwork_labor());
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      dialong(context, "ลงทะเบียนสำเร็จ");
    } else {
      dialong(context, "ไม่สามารถสมัครได้ กรุณาลองใหม่");
    }
  }

  Widget box1() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ข้าว"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box1,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box1 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box2() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ข้าวโพด"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box2,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box2 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box3() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("มันสำปะหลัง"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box3,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box3 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box4() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("อ้อย"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box4,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box4 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box5() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("พริก"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box5,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box5 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box6() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("มันเทศ"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box6,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box6 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box7() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ปาล์ม"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box7,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box7 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget box8() => Container(
        width: 180,
        child: CheckboxListTile(
          title: Text("ถั่ว"),
          checkColor: Colors.white,
          // fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked_box8,
          onChanged: (bool? value) {
            setState(() {
              isChecked_box8 = value!;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );

  Widget Dateform() => Container(
        padding: EdgeInsets.all(15),
        height: 100,
        width: 200,
        child: TextField(
          controller: dateinput, //editing controller of this TextField
          decoration: InputDecoration(
              icon: Icon(Icons.calendar_today), //icon of text field
              labelText: "เลือกวันที่เริ่มงาน" //label text of field
              ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            var dateTime = DateTime.now();
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: dateTime,
                firstDate: DateTime(
                    1950), //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.utc(dateTime.year, dateTime.month + 1,
                    dateTime.day, dateTime.hour, dateTime.minute));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              //you can implement different kind of Date Format here according to your requirement

              setState(() {
                dateinput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {
              print("Date is not selected");
            }
          },
        ),
      );
}
