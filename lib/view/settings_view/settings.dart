import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/admin_controller.dart';
import 'package:instattendance_admin/utils/storage_utils.dart';
import 'package:instattendance_admin/view/autentication_view/admin_auth.dart';

import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
  final AdminController _adminController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.indigoAccent,
          actions: [
            IconButton(
                onPressed: () {
                  StorageUtil storage = StorageUtil.storageInstance;
                  storage.clearPrefs();

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => AuthenticationView()),
                      (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 55,
              ),
              const Text('Admin Information'),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.6,
              ),
              ListTile(
                title: Text(_adminController.adminList[0]!.name.toString()),
                leading: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 14,
              ),
              ListTile(
                title: Text(_adminController.adminList[0]!.email.toString()),
                leading: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 24,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.6,
              ),
              CustomButton(
                msg: 'Delete Account',
                icon: Icons.delete,
                onTap: () async {
                  var isDeleted = await _adminController.deleteAdmin(
                      _adminController.adminList[0]!.email.toString());

                  DisplayMessage.showMsg(isDeleted.toString());

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => AuthenticationView()),
                      (route) => false);
                },
              )
            ],
          ),
        ));
  }
}
