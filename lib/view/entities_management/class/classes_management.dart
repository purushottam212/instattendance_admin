import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/widget/alert_dialog.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class ClassesManagement extends StatelessWidget {
  ClassesManagement({Key? key}) : super(key: key);
  final ClassController _classController = Get.find();
  final TextEditingController _classNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Classes Management', context),
      body: FutureBuilder(
        future: _classController
            .getAllClasses(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Please wait its loading...'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('All Availabel classes of departments'),
                      Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.6)),
                        padding: const EdgeInsets.all(28),
                        child: Obx(() => (_classController
                                .deptClasses.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: _classController.deptClasses.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_classController
                                              .deptClasses[index].className
                                              .toString()),
                                          IconButton(
                                              onPressed: () async {
                                                String res =
                                                    await _classController
                                                        .deleteClass(
                                                            _classController
                                                                .deptClasses[
                                                                    index]
                                                                .id);
                                                DisplayMessage.showMsg(res);
                                                if (res ==
                                                    "deleted class successfully") {
                                                  _classController.deptClasses
                                                      .remove(_classController
                                                          .deptClasses[index]);
                                                }
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.redAccent,
                                                  size: 16))
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                    ],
                                  );
                                })
                            : const Center(
                                child: Text(
                                    'classes are not added yet,,add class by hitting below button'),
                              ))),
                      ),
                      CustomButton(
                        msg: 'Add Class',
                        icon: Icons.add,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  controller: _classNameController,
                                  label: 'Enter Class Name:',
                                  onTap: () async {
                                    addClass(context);
                                  },
                                );
                              });
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future addClass(BuildContext context) async {
    if (_classNameController.text.isNotEmpty) {
      DeptClass addClass =
          DeptClass(className: _classNameController.text, subjects: []);
      DeptClass? addedClass = await _classController.addClass(addClass);

      if (addedClass != null) {
        DisplayMessage.showMsg(
            'Class Added with name ${_classNameController.text}');

        _classController.deptClasses.add(addedClass);
        Navigator.of(context).pop();
      }
    }
  }
}
