// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'dart:convert';

List<Subject> subjectListFromJson(String str) =>
    List<Subject>.from(json.decode(str).map((x) => Subject.fromJson(x)));

String subjectListToJson(List<Subject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

class Subject {
  Subject({this.subId, this.name, this.isPractical});

  int? subId;
  String? name;
  bool? isPractical;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        subId: json["subId"],
        name: json["name"],
        isPractical: json["isPractical"]
      );

  Map<String, dynamic> toJson() => {
        "subId": subId,
        "name": name,
        "isPractical":isPractical
      };
}
