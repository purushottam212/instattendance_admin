import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/controller/division_controller.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/models/division_model.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/selection_box_widget.dart';
import 'package:instattendance_admin/widget/show_toast.dart';
import 'package:instattendance_admin/widget/student_list.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  State<StudentManagement> createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  final StudentController _studentController = Get.find();
  final ClassController _classController = Get.find();
  final DivisionController _divisionController = Get.find();
  var _selectedClass;
  var _selectedDivision;
  int? _selectedClassId;
  int? _selectedDivId;
  bool _showStudentList = false;
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
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
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
                  await _getStudentsByClassAndDiv();
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
            _showStudentList
                ? StudentList(
                    studList: _studentController.studentsByClassAndDiv,selectedclass: _selectedClass,selectedDiv: _selectedDivision)
                : Container()
          ],
        ),
      ),
    );
  }

  _getStudentsByClassAndDiv() async {
    if (_selectedClass != null && _selectedDivision != null) {
      await _studentController.getAllStudentsByClassAndDiv(
          _selectedClassId!, _selectedDivId!);
      setState(() {
        _showStudentList = true;
      });
    } else {
      DisplayMessage.showMsg('Select class & div first...!!');
    }
  }
}
