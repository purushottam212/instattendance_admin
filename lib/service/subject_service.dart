import 'package:instattendance_admin/models/subject_model.dart';
import 'package:instattendance_admin/repository/subject_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class SubjectService {
  final SubjectRepository _subjectRepository = SubjectRepository();

  Future<Subject?> addSubject(Subject subject, String className) async {
    Subject? addSub;
    addSub = await _subjectRepository.addSubject(subject, className);
    /*try {
      addSub = await _subjectRepository.addSubject(subject, className);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }*/

    return addSub;
  }

  Future<List<Subject>?> getSubjectByClass(String className) async {
    List<Subject>? getSubjects;

    try {
      getSubjects = await _subjectRepository.getAllSubjectsByClass(className);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getSubjects;
  }

  Future<String> deleteSubject(int subId) async {
    String deleteSub = '';

    try {
      deleteSub = await _subjectRepository.deleteSubject(subId);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return deleteSub;
  }
}
