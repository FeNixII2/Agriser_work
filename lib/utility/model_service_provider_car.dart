import 'dart:convert';

ModelService_Pro_car welcomeFromJson(String str) =>
    ModelService_Pro_car.fromJson(json.decode(str));

String welcomeToJson(ModelService_Pro_car data) => json.encode(data.toJson());

class ModelService_Pro_car {
  ModelService_Pro_car({
    required this.id_service,
    required this.phone_provider,
    required this.type,
    required this.brand,
    required this.model,
    required this.date_buy,
    required this.prices,
    required this.image1,
    required this.image2,
    required this.status_work,
  });

  String id_service;
  String phone_provider;
  String type;
  String brand;
  String model;
  String date_buy;
  String prices;
  String image1;
  String image2;
  String status_work;

  factory ModelService_Pro_car.fromJson(Map<String, dynamic> json) =>
      ModelService_Pro_car(
        id_service: json["id_service"],
        phone_provider: json["phone_provider"],
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        date_buy: json["date_buy"],
        prices: json["prices"],
        image1: json["image1"],
        image2: json["image2"],
        status_work: json["status_work"],
      );

  Map<String, dynamic> toJson() => {
        "id_service": id_service,
        "phone_provider": phone_provider,
        "type": type,
        "brand": brand,
        "model": model,
        "date_buy": date_buy,
        "prices": prices,
        "image1": image1,
        "image2": image2,
        "status_work": status_work,
      };
}
