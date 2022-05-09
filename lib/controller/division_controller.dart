import 'package:get/get.dart';
import 'package:instattendance_admin/models/division_model.dart';
import 'package:instattendance_admin/service/division_service.dart';

class DivisionController extends GetxController {
  final DivisionService _divisionService = DivisionService();

  var divisions = List<Division>.empty(growable: true).obs;

  Future<Division?> addDivision(Division division) async {
    Division? div = await _divisionService.addDDivision(division);
    if (div != null) {
      return div;
    }
  }

  Future getAllDivisions() async {
    var divisionList = await _divisionService.getAllDivision();
    if (divisionList != null) {
      divisions.assignAll(divisionList);
    }
  }

  Future<String> deleteDivision(int? id) {
    return _divisionService.deleteDivision(id!);
  }
}
