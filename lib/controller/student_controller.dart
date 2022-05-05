import 'package:get/get.dart';
import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/models/student_model.dart';
import 'package:instattendance_admin/service/student_service.dart';

class StudentController extends GetxController {
  final StudentService _studentService = StudentService();

  var studentsByClassAndDiv = List<Student1>.empty(growable: true).obs;

  Future<Student?> addStudent(Student s) async {
    return await _studentService.addStudent(s);
  }

  Future getAllStudentsByClassAndDiv(int classId, int divId) async {
    print(classId);
    print(divId);
    var studentList =
        await _studentService.getStudentByClassAndDiv(classId, divId);

    if (studentList != null) {
      studentsByClassAndDiv.assignAll(studentList);
    }
  }

  Future<String> deleteStudent(String rollNo) async {
    return _studentService.deleteStudent(rollNo);
  }
}
