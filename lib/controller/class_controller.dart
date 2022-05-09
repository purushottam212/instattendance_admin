import 'package:get/get.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/service/class_service.dart';

class ClassController extends GetxController {
  final ClassService _classService = ClassService();

  var deptClasses = List<DeptClass>.empty(growable: true).obs;

  Future getAllClasses() async {
    var classes = await _classService.getAllClass();
    if (classes != null) {
      deptClasses.assignAll(classes);
    }
  }

  Future<DeptClass?> addClass(DeptClass classDetails) async {
    DeptClass? addedClass = await _classService.addClass(classDetails);
    if (addedClass != null) {
      return addedClass;
    }
  }

  Future<String> deleteClass(int? id) async {
    return _classService.deleteClass(id!);
  }
}
