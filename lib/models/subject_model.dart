// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

List<Subject> subjectListFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subject {
  Subject({
    this.name,
  });

  String? name;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
