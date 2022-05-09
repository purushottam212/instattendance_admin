// To parse this JSON data, do
//
//     final subject1 = subject1FromJson(jsonString);

import 'dart:convert';

List<Subject1> subject1ListFromJson(String str) => List<Subject1>.from(json.decode(str).map((x) => Subject1.fromJson(x)));

String subject1ListToJson(List<Subject1> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Subject1 subject1FromJson(String str) => Subject1.fromJson(json.decode(str));

String subject1ToJson(Subject1 data) => json.encode(data.toJson());

class Subject1 {
    Subject1({
        this.name,
        this.className,
    });

    String ? name;
    ClassName ? className;

    factory Subject1.fromJson(Map<String, dynamic> json) => Subject1(
        name: json["name"],
        className: ClassName.fromJson(json["className"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "className": className!.toJson(),
    };
}

class ClassName {
    ClassName({
        this.className,
    });

    String ? className;

    factory ClassName.fromJson(Map<String, dynamic> json) => ClassName(
        className: json["className"],
    );

    Map<String, dynamic> toJson() => {
        "className": className,
    };
}
