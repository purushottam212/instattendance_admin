import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/teacher_model.dart';

class TeacherRepository {
  Future<Teacher?> addTeacher(Teacher teacher) async {
    var body = jsonEncode({
      "email": teacher.email,
      "password": teacher.password,
      "name": teacher.name,
      "designation": teacher.designation,
      "roles": teacher.roles
    });

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/teachers'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return teacherFromJson(response.body);
    }

    return null;
  }

  Future<Teacher?> getTeacherByEmail(String email) async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/teachers/$email'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return teacherFromJson(response.body);
    }

    return null;
  }

  Future<List<Teacher>?> getAllTeacher() async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/teachers'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return teachersListFromJson(response.body);
    }

    return null;
  }

  Future<String> deleteTeacher(String email) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/teachers/$email'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return response.body;
    }

    return 'something went wrong';
  }

  Future<Teacher?> assignRole(String teacherEmail, int roleId) async {
    var body = jsonEncode({"teacherEmail": teacherEmail, "roleId": roleId});

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/teachers/assignroles'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return teacherFromJson(response.body);
    }
  }
}
