import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/teacher_contoller.dart';
import 'package:instattendance_admin/view/entities_management/teacher/add_teacher_form.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class TeachersManagement extends StatelessWidget {
  TeachersManagement({Key? key}) : super(key: key);
  final TeacherController _teacherController = Get.put(TeacherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Teachers Management', context),
      body: FutureBuilder(
          future: _teacherController.getAllTeacher(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: Text('Please wait its loading...'));
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomButton(
                          msg: 'Add Teacher',
                          icon: Icons.add,
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                builder: (builder) {
                                  return AddTeacherForm();
                                });
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 0.6)),
                          padding: const EdgeInsets.all(28),
                          child: Obx(() => (_teacherController
                                  .teachersList.isEmpty
                              ? const Center(
                                  child: Text('No Teacher added yet'))
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _teacherController.teachersList.length,
                                  itemBuilder: (context, index) {
                                    return ExpansionTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${_teacherController.teachersList[index].name}'),
                                          IconButton(
                                              onPressed: () async {
                                                String res =
                                                    await _teacherController
                                                        .deleteTeacher(
                                                            _teacherController
                                                                .teachersList[
                                                                    index]
                                                                .email
                                                                .toString());
                                                if (res ==
                                                    "deleted successfully") {
                                                  _teacherController
                                                      .teachersList
                                                      .remove(_teacherController
                                                          .teachersList[index]);
                                                  DisplayMessage.showMsg(
                                                      'Teacher Deleted');
                                                } else {
                                                  DisplayMessage.showMsg(res);
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                                size: 15,
                                              ))
                                        ],
                                      ),
                                      children: [
                                        Text(
                                            'Email: ${_teacherController.teachersList[index].email}\n'),
                                        Text(
                                            'Designation: ${_teacherController.teachersList[index].designation}\n'),
                                        Text(
                                            'Password: ${_teacherController.teachersList[index].password}\n'),
                                      ],
                                    );
                                  }))),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
