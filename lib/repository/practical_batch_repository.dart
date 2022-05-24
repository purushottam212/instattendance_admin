import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/practical_batch_model.dart';

class PracticalBatchRepository {
  Future<PracticalBatch?> createBatch(PracticalBatch batch) async {
    var body = jsonEncode({
      "batchName": batch.batchName,
      "className": batch.className,
      "division": batch.division
    });

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/batch'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return practicalBatchFromJson(response.body);
    }
    return null;
  }

  Future<List<PracticalBatch>?> getBatchesByClassAndDiv(
      String className, String division) async {
    var body = jsonEncode({"className": className, "divName": division});
    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/batch/classDiv'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return practicalBatchListFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);
    return null;
  }

  Future deleteBatch(int id) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/batch/$id'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    return response.body;
  }
}
