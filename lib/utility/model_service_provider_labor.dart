import 'dart:convert';

ModelService_Pro_labor welcomeFromJson(String str) =>
    ModelService_Pro_labor.fromJson(json.decode(str));

String welcomeToJson(ModelService_Pro_labor data) => json.encode(data.toJson());

class ModelService_Pro_labor {
  ModelService_Pro_labor({
    required this.id_service,
    required this.phone_provider,
    required this.type,
    required this.rice,
    required this.sweetcorn,
    required this.cassava,
    required this.sugarcane,
    required this.chili,
    required this.choice,
    required this.info_choice,
    required this.total_choice,
    required this.prices,
    required this.image1,
    required this.image2,
    required this.status_work,
  });

  String id_service;
  String phone_provider;
  String type;
  String rice;
  String sweetcorn;
  String cassava;
  String sugarcane;
  String chili;
  String choice;
  String info_choice;
  String total_choice;
  String prices;
  String image1;
  String image2;
  String status_work;

  factory ModelService_Pro_labor.fromJson(Map<String, dynamic> json) =>
      ModelService_Pro_labor(
        id_service: json["id_service"],
        phone_provider: json["phone_provider"],
        type: json["type"],
        rice: json["rice"],
        sweetcorn: json["sweetcorn"],
        cassava: json["cassava"],
        sugarcane: json["sugarcane"],
        chili: json["chili"],
        choice: json["choice"],
        info_choice: json["info_choice"],
        total_choice: json["total_choice"],
        prices: json["prices"],
        image1: json["image1"],
        image2: json["image2"],
        status_work: json["status_work"],
      );

  Map<String, dynamic> toJson() => {
        "id_service": id_service,
        "phone_provider": phone_provider,
        "type": type,
        "rice": rice,
        "sweetcorn": sweetcorn,
        "cassava": cassava,
        "sugarcane": sugarcane,
        "chili": chili,
        "choice": choice,
        "info_choice": info_choice,
        "total_choice": total_choice,
        "prices": prices,
        "image1": image1,
        "image2": image2,
        "status_work": status_work,
      };
}
