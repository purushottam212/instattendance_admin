// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

import 'package:instattendance_admin/models/teacher_model.dart';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

List<RoleModel> roleModelListFromJson(String str) =>
    List<RoleModel>.from(json.decode(str).map((x) => RoleModel.fromJson(x)));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  RoleModel({this.id, this.roleName, this.teachers});

  int? id;
  String? roleName;
  Set<Teacher>? teachers;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
      id: json["id"], roleName: json["roleName"], teachers: json["teachers"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "roleName": roleName, "teachers": teachers};
}
