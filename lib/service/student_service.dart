import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/models/student_model.dart';
import 'package:instattendance_admin/repository/student_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class StudentService {
  final StudentRepository _studentRepository = StudentRepository();

  Future<Student?> addStudent(Student student) async {
    Student? addStudent;

    try {
      addStudent = await _studentRepository.addStudent(student);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
    return addStudent;
  }

  Future<List<Student1>?> getStudentByClassAndDiv(
      int classId, int divId) async {
    List<Student1>? getStudents;

    try {
      getStudents =
          await _studentRepository.getStudentsByClassAndDiv(classId, divId);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
      print(e.toString());
    }

    return getStudents;
  }

  Future<String> deleteStudent(String rollNo) async {
    String studentDeleted = '';
    try {
      studentDeleted = await _studentRepository.deleteStudent(rollNo);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return studentDeleted;
  }
}
