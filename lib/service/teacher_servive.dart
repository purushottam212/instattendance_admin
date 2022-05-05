import 'package:instattendance_admin/models/teacher_model.dart';
import 'package:instattendance_admin/repository/teacher_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class TeacherService {
  final TeacherRepository _teacherRepository = TeacherRepository();

  Future<Teacher?> addTeacher(Teacher teacher) async {
    Teacher? addTeacher;

    try {
      addTeacher = await _teacherRepository.addTeacher(teacher);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return addTeacher;
  }

  Future<Teacher?> getTeacherByEmail(String email) async {
    Teacher? getTeacher;

    try {
      getTeacher = await _teacherRepository.getTeacherByEmail(email);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getTeacher;
  }

  Future<List<Teacher>?> getAllTeacher() async {
    List<Teacher>? getAllTeacher;

    try {
      getAllTeacher = await _teacherRepository.getAllTeacher();
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getAllTeacher;
  }

  Future<String> deleteTeacher(String email) async {
    String deleteTeacher = '';

    try {
      deleteTeacher = await _teacherRepository.deleteTeacher(email);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
    return deleteTeacher;
  }

  Future<Teacher?> assignRole(String teacherEmail, int roleId) async {
    Teacher? assignRoleToTeacher;

    try {
      assignRoleToTeacher =
          await _teacherRepository.assignRole(teacherEmail, roleId);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return assignRoleToTeacher;
  }
}
