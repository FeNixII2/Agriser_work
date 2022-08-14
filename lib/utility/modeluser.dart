import 'dart:convert';

Modeluser welcomeFromJson(String str) => Modeluser.fromJson(json.decode(str));

String welcomeToJson(Modeluser data) => json.encode(data.toJson());

class Modeluser {
  Modeluser({
    required this.phone,
    required this.password,
    required this.name,
    required this.email,
    required this.date,
    required this.sex,
    required this.address,
    required this.province,
    required this.district,
    required this.map_lat,
    required this.map_long,
    // required this.map,
  });

  String phone;
  String password;
  String name;
  String email;
  String date;
  String sex;
  String address;
  String province;
  String district;
  String map_lat;
  String map_long;
  // String map;

  factory Modeluser.fromJson(Map<String, dynamic> json) => Modeluser(
        phone: json["phone_user"],
        password: json["password_user"],
        name: json["name_user"],
        email: json["email_user"],
        date: json["date_user"],
        sex: json["sex_user"],
        address: json["address_user"],
        province: json["province_user"],
        district: json["district_user"],
        map_lat: json["map_lat_user"],
        map_long: json["map_long_user"],
        // map: json["map_user"],
      );

  Map<String, dynamic> toJson() => {
        "phone_user": phone,
        "password_user": password,
        "name_user": name,
        "email_user": email,
        "date_user": date,
        "sex_user": sex,
        "address_user": address,
        "province_user": province,
        "district_user": district,
        "map_lat_user": map_lat,
        "map_long_user": map_long,
        // "map_user": map,
      };
}
