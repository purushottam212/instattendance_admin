// To parse this JSON data, do
//
//     final teacher = teacherFromJson(jsonString);

import 'dart:convert';

Teacher teacherFromJson(String str) => Teacher.fromJson(json.decode(str));

String teacherToJson(Teacher data) => json.encode(data.toJson());

List<Teacher> teachersListFromJson(String str) =>
    List<Teacher>.from(json.decode(str).map((x) => Teacher.fromJson(x)));

String teachersListToJson(List<Teacher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teacher {
  Teacher({
    this.email,
    this.password,
    this.name,
    this.designation,
    this.roles,
  });

  String? email;
  String? password;
  String? name;
  String? designation;
  List<Role>? roles;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        designation: json["designation"],
        roles: List<Role>.from(json["roles"] == null
            ? []
            : json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "designation": designation,
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    this.roleName,
    this.teachers,
  });

  String? roleName;
  List<dynamic>? teachers;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleName: json["roleName"],
        teachers: List<dynamic>.from(json["teachers"] == null?[]:  json["teachers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "roleName": roleName,
        "teachers": List<dynamic>.from(teachers!.map((x) => x)),
      };
}
