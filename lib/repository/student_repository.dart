import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/models/student_model.dart';

class StudentRepository {
  Future<Student?> addStudent(Student student) async {
    var body = jsonEncode({
      "rollNo": student.rollNo,
      "prnNo": student.prnNo,
      "name": student.name,
      "practicalBatch": student.practicalBatch,
      "studentClass": student.studentClass,
      "studentDivision": student.studentDivision
    });

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/students'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return studentFromJson(response.body);
    }
    return null;
  }

  Future<List<Student1>?> getStudentsByClassAndDiv(
      int classId, int divId) async {
    var body = jsonEncode({"classId": classId, "divId": divId});
    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/studentsByClassAndDiv'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return student1ListFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);
    return null;
  }

  Future<String> deleteStudent(String rollNo) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/students/$rollNo'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return 'student deleted';
    }

    return 'something went wrong';
  }

  Future<List<Student1>?> getStudentsByBatch(String batchName) async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/students/batch/$batchName'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return student1ListFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);
    return null;
  }

  
}
