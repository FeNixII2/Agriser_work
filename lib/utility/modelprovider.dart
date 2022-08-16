import 'dart:convert';

Modelprovider welcomeFromJson(String str) =>
    Modelprovider.fromJson(json.decode(str));

String welcomeToJson(Modelprovider data) => json.encode(data.toJson());

class Modelprovider {
  Modelprovider({
    required this.phone,
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

  factory Modelprovider.fromJson(Map<String, dynamic> json) => Modelprovider(
        phone: json["phone_provider"],

        name: json["name_provider"],
        email: json["email_provider"],
        date: json["date_provider"],
        sex: json["sex_provider"],
        address: json["address_provider"],
        province: json["province_provider"],
        district: json["district_provider"],
        map_lat: json["map_lat_provider"],
        map_long: json["map_long_provider"],
        // map: json["map_user"],
      );

  Map<String, dynamic> toJson() => {
        "phone_provider": phone,

        "name_provider": name,
        "email_provider": email,
        "date_provider": date,
        "sex_provider": sex,
        "address_provider": address,
        "province_provider": province,
        "district_provider": district,
        "map_lat_provider": map_lat,
        "map_long_provider": map_long,
        // "map_user": map,
      };
}
