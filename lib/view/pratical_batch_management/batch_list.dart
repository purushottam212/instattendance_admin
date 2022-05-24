import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/practical_batch_controller.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/view/pratical_batch_management/batchwise_student.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class BatchesList extends StatelessWidget {
  BatchesList({Key? key, this.selectedClass, this.selectDiv}) : super(key: key);
  final PracticalBatchController _practicalBatchController = Get.find();
  final StudentController _studentController = Get.find();
  final String? selectedClass;
  final String? selectDiv;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            _practicalBatchController.batchList.isEmpty
                ? const Center(
                    child: Text('No Batches Added Yet'),
                  )
                : Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _practicalBatchController.batchList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              var list = await _studentController
                                  .getStudentsByBatch(_practicalBatchController
                                      .batchList[index].batchName
                                      .toString());
                              if (list != null) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BatchwiseStudentPage(
                                          selectedClass: selectedClass,
                                          selectedDiv: selectDiv,
                                          selectedBatch:
                                              _practicalBatchController
                                                  .batchList[index].batchName
                                                  .toString(),
                                        )));
                              }
                            },
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_practicalBatchController
                                        .batchList[index].batchName
                                        .toString()),
                                    IconButton(
                                        onPressed: () async {
                                          var res =
                                              await _practicalBatchController
                                                  .deleteBatch(
                                                      _practicalBatchController
                                                          .batchList[index]
                                                          .id!);
                                          DisplayMessage.showMsg(res);
                                          _practicalBatchController.batchList
                                              .remove(_practicalBatchController
                                                  .batchList[index]);
                                        },
                                        icon: const Icon(Icons.delete,
                                            color: Colors.redAccent, size: 16))
                                  ],
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
          ],
        ));
  }
}
