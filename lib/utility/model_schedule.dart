import 'dart:convert';

Model_schedule welcomeFromJson(String str) =>
    Model_schedule.fromJson(json.decode(str));

String welcomeToJson(Model_schedule data) => json.encode(data.toJson());

class Model_schedule {
  Model_schedule({
    required this.id_schedule,
    required this.id_service,
    required this.phone_user,
    required this.phone_provider,
    required this.date_work,
    required this.count_field,
    required this.total_price,
    required this.map_lat_work,
    required this.map_long_work,
    required this.status,
  });

  String id_schedule;
  String id_service;
  String phone_user;
  String phone_provider;
  String date_work;
  String count_field;
  String total_price;
  String map_lat_work;
  String map_long_work;
  String status;

  factory Model_schedule.fromJson(Map<String, dynamic> json) => Model_schedule(
        id_schedule: json["id_schedule"],
        id_service: json["id_service"],
        phone_user: json["phone_user"],
        phone_provider: json["phone_provider"],
        date_work: json["date_work"],
        count_field: json["count_field"],
        total_price: json["total_price"],
        map_lat_work: json["map_lat_work"],
        map_long_work: json["map_long_work"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_schedule": id_schedule,
        "id_service": id_service,
        "phone_user": phone_user,
        "phone_provider": phone_provider,
        "date_work": date_work,
        "count_field": count_field,
        "total_price": total_price,
        "map_lat_work": map_lat_work,
        "map_long_work": map_long_work,
        "status": status,
      };
}
