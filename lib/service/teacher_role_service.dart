import 'package:instattendance_admin/models/teacher_roles_model.dart';
import 'package:instattendance_admin/repository/teacher_roles_repository.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class TeacherRoleService {
  final RolesRepository _rolesRepository = RolesRepository();

  Future<RoleModel?> addRole(RoleModel role) async {
    RoleModel? addRole;

    try {
      addRole = await _rolesRepository.addRole(role);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return addRole;
  }

  Future<RoleModel?> getRole(int roleId) async {
    RoleModel? role;

    try {
      role = await _rolesRepository.getRole(roleId);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
    return role;
  }

  Future<List<RoleModel>?> getAllRoles() async {
    List<RoleModel>? getAllRoles;

    try {
      getAllRoles = await _rolesRepository.getAllRoles();
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }

    return getAllRoles;
  }

  Future<String> deleteRole(int roleId) async {
    String deleteRole = '';

    try {
      deleteRole = await _rolesRepository.deleteRole(roleId);
    } catch (e) {
      DisplayMessage.showMsg(e.toString());
    }
    return deleteRole;
  }
}
