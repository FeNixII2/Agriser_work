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
    required this.image_car,
    required this.image_car_2,
  });

  String id_service;
  String phone_provider;
  String type;
  String brand;
  String model;
  String date_buy;
  String prices;
  String image_car;
  String image_car_2;

  factory ModelService_Pro_car.fromJson(Map<String, dynamic> json) =>
      ModelService_Pro_car(
        id_service: json["id_service"],
        phone_provider: json["phone_provider"],
        type: json["type"],
        brand: json["brand"],
        model: json["model"],
        date_buy: json["date_buy"],
        prices: json["prices"],
        image_car: json["image_car"],
        image_car_2: json["image_car_2"],
      );

  Map<String, dynamic> toJson() => {
        "id_service": id_service,
        "phone_provider": phone_provider,
        "type": type,
        "brand": brand,
        "model": model,
        "date_buy": date_buy,
        "prices": prices,
        "image_car": image_car,
        "image_car_2": image_car_2,
      };
}
