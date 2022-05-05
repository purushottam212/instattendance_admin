//only name rool no , prn no

// To parse this JSON data, do
//
//     final student1 = student1FromJson(jsonString);

import 'dart:convert';

Student1 student1FromJson(String str) => Student1.fromJson(json.decode(str));
List<Student1> student1ListFromJson(String str) =>
    List<Student1>.from(json.decode(str).map((x) => Student1.fromJson(x)));

String student1ToJson(Student1 data) => json.encode(data.toJson());

class Student1 {
  Student1({
    this.prnNo,
    this.rollNo,
    this.name,
  });

  String? prnNo;
  String? rollNo;
  String? name;

  factory Student1.fromJson(Map<String, dynamic> json) => Student1(
        prnNo: json["prnNo"],
        rollNo: json["rollNo"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "prnNo": prnNo,
        "rollNo": rollNo,
        "name": name,
      };
}
