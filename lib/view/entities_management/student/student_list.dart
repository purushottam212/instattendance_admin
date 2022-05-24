import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/view/entities_management/student/add_student_form.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class StudentList extends StatelessWidget {
  StudentList(
      {Key? key,
      required this.studList,
      required this.selectedclass,
      required this.selectedDiv})
      : super(key: key);
  final List<Student1> studList;
  final StudentController _studentController = Get.find();
  final selectedclass;
  final selectedDiv;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.6)),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              builder: (builder) {
                                return AddStudentForm(
                                    selectedClass: selectedclass,
                                    selectedDiv: selectedDiv);
                              });
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('add Student'))),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: studList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${studList[index].name}'),
                            IconButton(
                                onPressed: () async {
                                  String res =
                                      await _studentController.deleteStudent(
                                          studList[index].rollNo.toString());
                                  if (res == 'student deleted') {
                                    studList.remove(studList[index]);
                                    DisplayMessage.showMsg(res);
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
                          Text('PRN No : ${studList[index].prnNo}'),
                          Text('Roll No : ${studList[index].rollNo}'),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
