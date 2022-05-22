import 'package:instattendance_admin/models/admin_model.dart';
import 'package:instattendance_admin/repository/admin_repository.dart';
import 'package:instattendance_admin/utils/storage_utils.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class AdminService {
  final AdminRepository _adminRepository = AdminRepository();

  Future<Admin?> addAdmin(Admin admin) async {
    Admin? addAdmin;
    try {
      addAdmin = await _adminRepository.addAdmin(admin);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return addAdmin;
  }

  Future deleteAdmin(String email) async {
    var isDeleted = '';

    try {
      isDeleted = await _adminRepository.deleteAdmin(email);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return isDeleted;
  }

  Future<Admin?> authenticateAdmin(String email, String password) async {
    try {
      Admin? admin = await _adminRepository.authenticateAdmin(email, password);
      if (admin != null) {
        final StorageUtil storage = StorageUtil.storageInstance;
        if (storage.getPrefs('email')!.isEmpty &&
            storage.getPrefs('password')!.isEmpty) {
          storage.addStringtoSF('email', admin.email!);
          storage.addStringtoSF('password', admin.password!);
        }

        return admin;
      } else {
        DisplayMessage.showMsg('Credentials are incorrect');
      }
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
      print(e.toString());
    }
  }
}
