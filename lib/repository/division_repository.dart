import 'dart:convert';

import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/division_model.dart';
import 'package:http/http.dart' as http;

class DivisionRepository {
  Future<Division?> addDivision(Division division) async {
    var body = jsonEncode(
        {"div_id": division.id, "divisionName": division.divisionName});

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/divisions'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return divisionFromJson(response.body);
    }
    return null;
  }

  Future<List<Division>?> getAllDivisions() async {
    var response = await http.get(
      Uri.parse('${RepositoryConstants.baseUrl}/divisions'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return divisionListFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);

    return null;
  }

  Future<Division?> findDivByName(String divName) async {
    var response = await http.get(Uri.parse(
        '${RepositoryConstants.baseUrl}/findDivisionByName/$divName'));
    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return divisionFromJson(response.body);
    }

    RepositoryConstants.validateErrorCodes(response.statusCode);
  }

  Future<String> deleteDivision(int id) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/division/$id'),
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
