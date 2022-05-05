// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

List<RoleModel> roleModelListFromJson(String str) =>
    List<RoleModel>.from(json.decode(str).map((x) => RoleModel.fromJson(x)));

String roleModelToJson(RoleModel data) => json.encode(data.toJson());

class RoleModel {
  RoleModel({
    this.id,
    this.roleName,
  });

  int? id;
  String? roleName;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        roleName: json["roleName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
      };
}
