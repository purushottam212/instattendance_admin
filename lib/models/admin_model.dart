// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

List<Admin> adminListFromJson(String str) =>
    List<Admin>.from(json.decode(str).map((x) => Admin.fromJson(x)));

String adminListToJson(List<Admin> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  Admin({
    this.email,
    this.name,
    this.password,
  });

  String? email;
  String? name;
  String? password;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        email: json["email"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "password": password,
      };
}
