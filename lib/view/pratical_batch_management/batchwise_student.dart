import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class BatchwiseStudentPage extends StatelessWidget {
  BatchwiseStudentPage(
      {Key? key, this.selectedBatch, this.selectedClass, this.selectedDiv})
      : super(key: key);
  final StudentController _studentController = Get.find();
  final String? selectedBatch;
  final String? selectedClass;
  final String? selectedDiv;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(
            '$selectedClass - $selectedDiv Batch- $selectedBatch', context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 0.6)),
            child: SingleChildScrollView(
              child: Obx(
                () => _studentController.studentsByBatch.isEmpty
                    ? const Center(
                        child: Text('No Students In This Batch'),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  _studentController.studentsByBatch.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${_studentController.studentsByBatch[index].name}'),
                                      IconButton(
                                          onPressed: () async {
                                            String res =
                                                await _studentController
                                                    .deleteStudent(
                                                        _studentController
                                                            .studentsByBatch[
                                                                index]
                                                            .rollNo
                                                            .toString());
                                            if (res == 'student deleted') {
                                              _studentController.studentsByBatch
                                                  .remove(_studentController
                                                      .studentsByBatch[index]);
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
                                    Text(
                                        'PRN No : ${_studentController.studentsByBatch[index].prnNo}'),
                                    Text(
                                        'Roll No : ${_studentController.studentsByBatch[index].rollNo}')
                                  ],
                                );
                              }),
                        ],
                      ),
              ),
            ),
          ),
        ));
  }
}
