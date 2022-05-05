// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

List<Student> studentListFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));
Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student({
    required this.prnNo,
    required this.rollNo,
    required this.name,
    required this.studentClass,
    required this.studentDivision,
  });

  String prnNo;
  String rollNo;
  String name;
  StudentClass studentClass;
  StudentDivision studentDivision;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        prnNo: json["prnNo"],
        rollNo: json["rollNo"],
        name: json["name"],
        studentClass: StudentClass.fromJson(json["studentClass"]),
        studentDivision: StudentDivision.fromJson(json["studentDivision"]),
      );

  Map<String, dynamic> toJson() => {
        "prnNo": prnNo,
        "rollNo": rollNo,
        "name": name,
        "studentClass": studentClass.toJson(),
        "studentDivision": studentDivision.toJson(),
      };
}

class StudentClass {
  StudentClass({
    required this.className,
    required this.students,
  });

  String className;
  List<dynamic> students;

  factory StudentClass.fromJson(Map<String, dynamic> json) => StudentClass(
        className: json["className"],
        students: List<dynamic>.from(json["students"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "className": className,
        "students": List<dynamic>.from(students.map((x) => x)),
      };
}

class StudentDivision {
  StudentDivision({
    required this.divisionName,
    required this.students,
  });

  String divisionName;
  List<dynamic> students;

  factory StudentDivision.fromJson(Map<String, dynamic> json) =>
      StudentDivision(
        divisionName: json["divisionName"],
        students: List<dynamic>.from(json["students"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "divisionName": divisionName,
        "students": List<dynamic>.from(students.map((x) => x)),
      };
}
