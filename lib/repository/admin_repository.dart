import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/admin_model.dart';

class AdminRepository {
  Future<Admin?> addAdmin(Admin admin) async {
    var body = jsonEncode(
        {"email": admin.email, "name": admin.name, "password": admin.password});

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/admin'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return adminFromJson(response.body);
    }
    return null;
  }

  Future<Admin?> authenticateAdmin(String email, String password) async {
    var body = jsonEncode({"email": email, "password": password});
    var response = await http.post(
      Uri.parse("${RepositoryConstants.baseUrl}/admin/authenticate"),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return adminFromJson(response.body);
    }
    return null;
  }

  Future deleteAdmin(String email) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/admin/$email'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    return response.body;
  }
}
