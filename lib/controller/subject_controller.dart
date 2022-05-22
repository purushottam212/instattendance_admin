import 'package:get/get.dart';
import 'package:instattendance_admin/models/subject_model.dart';
import 'package:instattendance_admin/service/subject_service.dart';

class SubjectController extends GetxController {
  final SubjectService _subjectService = SubjectService();

  var subByClass = List<Subject>.empty(growable: true).obs;

  Future addSubject(Subject subject, String className) async {
    Subject? sub = await _subjectService.addSubject(subject, className);

    if (sub != null) {
      return sub;
    }
  }

  Future getSubjectByClass(String className) async {
    var getAllSub = await _subjectService.getSubjectByClass(className);
    subByClass.clear();
    if (getAllSub != null) {
      subByClass.assignAll(getAllSub);
    }
  }

  Future<String> deleteSubject(int? subId) async {
    return _subjectService.deleteSubject(subId!);
  }
}
