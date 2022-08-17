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
    required this.yam,
    required this.palm,
    required this.bean,
    required this.prices,
    required this.image_labor,
  });

  String id_service;
  String phone_provider;
  String type;
  String rice;
  String sweetcorn;
  String cassava;
  String sugarcane;
  String chili;
  String yam;
  String palm;
  String bean;
  String prices;
  String image_labor;

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
        yam: json["yam"],
        palm: json["palm"],
        bean: json["bean"],
        prices: json["prices"],
        image_labor: json["image_labor"],
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
        "yam": yam,
        "palm": palm,
        "bean": bean,
        "prices": prices,
        "image_labor": image_labor,
      };
}
