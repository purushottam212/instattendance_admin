import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/teacher_roles_model.dart';

class RolesRepository {
  Future<RoleModel?> addRole(RoleModel role) async {
    var body = jsonEncode({"id": role.id, "roleName": role.roleName});

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/roles'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return roleModelFromJson(response.body);
    }
  }

  Future<RoleModel?> getRole(int roleId) async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/roles/$roleId'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return roleModelFromJson(response.body);
    }
  }

  Future<List<RoleModel>?> getAllRoles() async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/roles'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return roleModelListFromJson(response.body);
    }
  }

  Future<String> deleteRole(int roleId) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/roles/$roleId'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return response.body;
    }

    return ' something went wrong';
  }
}
