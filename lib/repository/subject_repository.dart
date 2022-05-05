import 'package:instattendance_admin/constants/repository_constants.dart';
import 'package:instattendance_admin/models/subject_model.dart';
import 'package:http/http.dart' as http;

class SubjectRepository {
  Future<Subject?> addSubject(Subject subject, String className) async {
    var body = {
      "name": subject.name,
      "className": {"className": className}
    };

    var response = await http.post(
      Uri.parse('${RepositoryConstants.baseUrl}/subjects'),
      body: body,
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return subjectFromJson(response.body);
    }
    RepositoryConstants.validateErrorCodes(response.statusCode);
    return null;
  }

  Future<List<Subject>?> getAllSubjectsByClass(String className) async {
    var response = await http.get(
        Uri.parse('${RepositoryConstants.baseUrl}/subjects/class/$className'));

    if (response.statusCode == RepositoryConstants.statusSuccessful) {
      return subjectListFromJson(response.body);
    }

    RepositoryConstants.validateErrorCodes(response.statusCode);
    return null;
  }

  Future<String> deleteSubject(int subId) async {
    var response = await http.delete(
      Uri.parse('${RepositoryConstants.baseUrl}/subjects/$subId'),
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
      },
    );

    if (response.statusCode == RepositoryConstants.statusSuccessful &&
        response.body.isNotEmpty) {
      return response.body;
    }

    RepositoryConstants.validateErrorCodes(response.statusCode);
    return 'Something went Wrong';
  }
}
