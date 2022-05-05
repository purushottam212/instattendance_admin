import 'dart:convert';

import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:http/http.dart' as http;

class ClassRepository {
  Future<DeptClass?> addClass(DeptClass classDetails) async {
    var body = jsonEncode({
      "id": classDetails.id,
      "className": classDetails.className,
      "subjects": classDetails.subjects
    });

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/classes'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return deptClassFromJson(response.body);
    }
    return null;
  }

  Future<List<DeptClass>?> getAllClasses() async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/classes'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return deptClassListFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);

    return null;
  }

  Future<DeptClass?> findClassByName(String className) async {
    var response = await http.get(
        Uri.parse('${RepositoryConstants.baseUrl}/findClassByName/$className'));
    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return deptClassFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);
  }

  Future<String> deleteClass(int id) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/classes/$id'),
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
}
