import 'dart:convert';

Modelpresentwork_car welcomeFromJson(String str) =>
    Modelpresentwork_car.fromJson(json.decode(str));

String welcomeToJson(Modelpresentwork_car data) => json.encode(data.toJson());

class Modelpresentwork_car {
  Modelpresentwork_car({
    required this.id_presentwork,
    required this.phone_user,
    required this.type_presentwork,
    required this.count_field,
    required this.img_field1,
    required this.img_field2,
    required this.date_work,
    required this.details,
    required this.prices,
    required this.map_lat_work,
    required this.map_long_work,
    required this.status_work,
  });

  String id_presentwork;
  String phone_user;
  String type_presentwork;
  String count_field;
  String img_field1;
  String img_field2;
  String date_work;
  String details;
  String prices;
  String map_lat_work;
  String map_long_work;
  String status_work;

  factory Modelpresentwork_car.fromJson(Map<String, dynamic> json) =>
      Modelpresentwork_car(
        id_presentwork: json["id_presentwork"],
        phone_user: json["phone_user"],
        type_presentwork: json["type_presentwork"],
        count_field: json["count_field"],
        img_field1: json["img_field1"],
        img_field2: json["img_field2"],
        date_work: json["date_work"],
        details: json["details"],
        prices: json["prices"],
        map_lat_work: json["map_lat_work"],
        map_long_work: json["map_long_work"],
        status_work: json["status_work"],
      );

  Map<String, dynamic> toJson() => {
        "id_presentwork": id_presentwork,
        "phone_user": phone_user,
        "type_presentwork": type_presentwork,
        "count_field": count_field,
        "img_field1": img_field1,
        "img_field2": img_field2,
        "date_work": date_work,
        "details": details,
        "prices": prices,
        "map_lat_work": map_lat_work,
        "map_long_work": map_long_work,
        "status_work": status_work,
      };
}
