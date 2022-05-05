import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/repository/class_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class ClassService {
  final ClassRepository _classRepository = ClassRepository();

  Future<DeptClass?> addClass(DeptClass classDetails) async {
    DeptClass? addClass;
    try {
      addClass = await _classRepository.addClass(classDetails);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return addClass;
  }

  Future<List<DeptClass>?> getAllClass() async {
    List<DeptClass>? getClasses;
    try {
      getClasses = await _classRepository.getAllClasses();
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getClasses;
  }

  Future<DeptClass?> findClassByName(String className) async {
    DeptClass? foundClass;

    try {
      foundClass = await _classRepository.findClassByName(className);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return foundClass;
  }

  Future<String> deleteClass(int id) async {
    String isDeleted='';

    try {
      isDeleted = await _classRepository.deleteClass(id);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return isDeleted;
  }
}
