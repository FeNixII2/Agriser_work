import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.phone_user,
    required this.name_user,
    required this.password_user,
  });

  String phone_user;
  String name_user;
  String password_user;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        phone_user: json["phone_user"],
        name_user: json["name_user"],
        password_user: json["password_user"],
      );

  Map<String, dynamic> toJson() => {
        "phone_user": phone_user,
        "name_user": name_user,
        "password_user": password_user,
      };
}
