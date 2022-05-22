import 'package:get/get.dart';
import 'package:instattendance_admin/models/teacher_model.dart';
import 'package:instattendance_admin/service/teacher_servive.dart';

class TeacherController extends GetxController {
  final TeacherService _teacherService = TeacherService();

  var teachersList = List<Teacher>.empty(growable: true).obs;

  Future addTeacher(Teacher teacher) async {
    return await _teacherService.addTeacher(teacher);
  }

  Future getAllTeacher() async {
    List<Teacher>? getTeachers;

    getTeachers = await _teacherService.getAllTeacher();

    if (getTeachers != null) {
      teachersList.assignAll(getTeachers);
    }
  }

  Future<String> deleteTeacher(String email) {
    return _teacherService.deleteTeacher(email);
  }
}
