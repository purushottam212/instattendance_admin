import 'package:instattendance_admin/models/division_model.dart';
import 'package:instattendance_admin/repository/division_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class DivisionService {
  final DivisionRepository _divisionRepository = DivisionRepository();

  Future<Division?> addDDivision(Division division) async {
    Division? addDivision;

    try {
      addDivision = await _divisionRepository.addDivision(division);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return addDivision;
  }

  Future<List<Division>?> getAllDivision() async {
    List<Division>? getAllDivision;

    try {
      getAllDivision = await _divisionRepository.getAllDivisions();
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getAllDivision;
  }

  Future<Division?> findDivisionByName(String divName) async {
    Division? division;

    try {
      division = await _divisionRepository.findDivByName(divName);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return division;
  }

  Future<String> deleteDivision(int id) async {
    String isDeleted = '';

    try {
      isDeleted = await _divisionRepository.deleteDivision(id);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return isDeleted;
  }
}
