import 'dart:convert';

Modelpresentwork_labor welcomeFromJson(String str) =>
    Modelpresentwork_labor.fromJson(json.decode(str));

String welcomeToJson(Modelpresentwork_labor data) => json.encode(data.toJson());

class Modelpresentwork_labor {
  Modelpresentwork_labor({
    required this.id_presentwork,
    required this.type_presentwork,
    required this.phone_user,
    required this.count_field,
    required this.rice,
    required this.sweetcorn,
    required this.cassava,
    required this.sugarcane,
    required this.chili,
    required this.details,
    required this.choice,
    required this.info_choice,
    required this.prices,
    required this.img_field1,
    required this.img_field2,
    required this.map_lat_work,
    required this.map_long_work,
    required this.status_work,
    required this.date_work,
    required this.total_choice,
  });

  String id_presentwork;
  String type_presentwork;
  String phone_user;
  String count_field;
  String prices;
  String details;
  String date_work;
  String img_field1;
  String img_field2;
  String map_lat_work;
  String map_long_work;
  String status_work;
  String rice;
  String sweetcorn;
  String cassava;
  String sugarcane;
  String chili;
  String choice;
  String info_choice;
  String total_choice;

  factory Modelpresentwork_labor.fromJson(Map<String, dynamic> json) =>
      Modelpresentwork_labor(
        id_presentwork: json["id_presentwork"],
        type_presentwork: json["type_presentwork"],
        phone_user: json["phone_user"],
        count_field: json["count_field"],
        prices: json["prices"],
        details: json["details"],
        date_work: json["date_work"],
        img_field1: json["img_field1"],
        img_field2: json["img_field2"],
        map_lat_work: json["map_lat_work"],
        map_long_work: json["map_long_work"],
        status_work: json["status_work"],
        rice: json["rice"],
        sweetcorn: json["sweetcorn"],
        cassava: json["cassava"],
        sugarcane: json["sugarcane"],
        chili: json["chili"],
        choice: json["choice"],
        info_choice: json["info_choice"],
        total_choice: json["total_choice"],
      );

  Map<String, dynamic> toJson() => {
        "id_presentwork": id_presentwork,
        "type_presentwork": type_presentwork,
        "phone_user": phone_user,
        "count_field": count_field,
        "prices": prices,
        "details": details,
        "date_work": date_work,
        "img_field1": img_field1,
        "img_field2": img_field2,
        "map_lat_work": map_lat_work,
        "map_long_work": map_long_work,
        "status_work": status_work,
        "rice": rice,
        "sweetcorn": sweetcorn,
        "cassava": cassava,
        "sugarcane": sugarcane,
        "chili": chili,
        "choice": choice,
        "info_choice": info_choice,
        "total_choice": total_choice,
      };
}
