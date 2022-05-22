import 'package:get/get.dart';
import 'package:instattendance_admin/models/admin_model.dart';
import 'package:instattendance_admin/service/admin_service.dart';

class AdminController extends GetxController {
  final AdminService _adminService = AdminService();
  var adminList = List<Admin?>.empty(growable: true).obs;
  var isLoading = false.obs;
  Future<Admin?> addClass(Admin admin) async {
    Admin? addedAdmin = await _adminService.addAdmin(admin);
    if (addedAdmin != null) {
      return addedAdmin;
    }
  }

  Future deleteAdmin(String email) async {
    return _adminService.deleteAdmin(email);
  }

  Future<Admin?> authenticateAdmin(String email, String password) async {
    isLoading(true);
    adminList.clear();
    Admin? admin = await _adminService.authenticateAdmin(email, password);
    adminList.add(admin);
    isLoading(false);
    return admin;
  }
}
