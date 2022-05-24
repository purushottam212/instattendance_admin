import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/controller/division_controller.dart';
import 'package:instattendance_admin/controller/practical_batch_controller.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/models/division_model.dart';
import 'package:instattendance_admin/models/practical_batch_model.dart';
import 'package:instattendance_admin/view/pratical_batch_management/batch_list.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/selection_box_widget.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class PracticalBatchPage extends StatefulWidget {
  const PracticalBatchPage({Key? key}) : super(key: key);

  @override
  State<PracticalBatchPage> createState() => _PracticalBatchPageState();
}

class _PracticalBatchPageState extends State<PracticalBatchPage> {
  final ClassController _classController = Get.find();
  final DivisionController _divisionController = Get.find();
  final PracticalBatchController _practicalBatchController = Get.find();

  final TextEditingController _batchNameController = TextEditingController();

  var _selectedClass;
  var _selectedDivision;
  int? _selectedClassId;
  int? _selectedDivId;
  bool _showBatchList = false;
  @override
  void initState() {
    super.initState();
    if (_divisionController.divisions.isEmpty ||
        _classController.deptClasses.isEmpty) {
      getDivisionAndClass();
    }
  }

  getDivisionAndClass() async {
    await _classController.getAllClasses();
    await _divisionController.getAllDivisions();

    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbar('Practical Batch Management', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                SelectionBox(
                  height: height,
                  width: width,
                  child: DropdownButton<DeptClass>(
                    hint: _selectedClass == null
                        ? const Text(
                            'select class',
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(_selectedClass.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                    items: _classController.deptClasses.isEmpty
                        ? null
                        : _classController.deptClasses.map((DeptClass value) {
                            return DropdownMenuItem<DeptClass>(
                              value: value,
                              child: Text(value.className.toString()),
                            );
                          }).toList(),
                    onChanged: (deptClass) {
                      setState(() {
                        _selectedClass = deptClass!.className.toString();
                        _selectedClassId = deptClass.id!;
                      });
                    },
                  ),
                ),
                SelectionBox(
                  height: height,
                  width: width,
                  child: DropdownButton<Division>(
                    hint: _selectedDivision == null
                        ? const Text(
                            'select div',
                            style: TextStyle(fontSize: 12),
                          )
                        : Text(_selectedDivision.toString(),
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                    items: _divisionController.divisions.isEmpty
                        ? null
                        : _divisionController.divisions.map((Division value) {
                            return DropdownMenuItem<Division>(
                              value: value,
                              child: Text(value.divisionName.toString()),
                            );
                          }).toList(),
                    onChanged: (division) {
                      setState(() {
                        _selectedDivision = division!.divisionName.toString();
                        _selectedDivId = division.id!;
                      });
                    },
                  ),
                )
              ],
            ),
            CustomButton(
                msg: 'Submit',
                icon: Icons.done,
                onTap: () async {
                  await getBatchesByClassAndDiv();
                }),
            const SizedBox(
              height: 12,
            ),
            const Divider(
              thickness: 1.3,
            ),
            const SizedBox(
              height: 12,
            ),
            _showBatchList
                ? BatchesList(
                    selectedClass: _selectedClass,
                    selectDiv: _selectedDivision,
                  )
                : Container(),
            const SizedBox(
              height: 12,
            ),
            _showBatchList
                ? CustomButton(
                    msg: 'Add Batch',
                    icon: Icons.done,
                    onTap: () async {
                      await addBatchesForm();
                    })
                : Container(),
          ],
        ),
      ),
    );
  }

  getBatchesByClassAndDiv() async {
    if (_selectedClass != null && _selectedDivId != null) {
      await _practicalBatchController.getPracticalBatches(
          _selectedClass, _selectedDivision);
      setState(() {
        _showBatchList = true;
      });
    } else {
      DisplayMessage.showMsg('Please Select Class & Division');
    }
  }

  addBatchesForm() async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                  'Add Practical Batch of $_selectedClass $_selectedDivision'),
              actions: [
                const Divider(
                  color: Colors.grey,
                  thickness: .4,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _batchNameController,
                  decoration:
                      const InputDecoration(labelText: 'Enter batch name'),
                ),
                TextButton(
                    onPressed: () async {
                      await addBatch();
                    },
                    child: const Text('Done'))
              ],
            ));
  }

  addBatch() async {
    if (_selectedClass != null &&
        _selectedDivision != null &&
        _batchNameController.text.isNotEmpty) {
      PracticalBatch batch = PracticalBatch(
          batchName: _batchNameController.text,
          className: _selectedClass,
          division: _selectedDivision);
      PracticalBatch? bt = await _practicalBatchController.createBatch(batch);
      if (bt != null) {
        DisplayMessage.showMsg('Batch added');
        _practicalBatchController.batchList.add(bt);
      }
    }
    Navigator.of(context).pop();
  }
}
