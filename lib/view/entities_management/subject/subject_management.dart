import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/controller/subject_controller.dart';
import 'package:instattendance_admin/models/class_model.dart';
import 'package:instattendance_admin/models/subject_model.dart' as sub;

import 'package:instattendance_admin/widget/alert_dialog.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/selection_box_widget.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class SubjectsManagement extends StatefulWidget {
  const SubjectsManagement({Key? key}) : super(key: key);

  @override
  State<SubjectsManagement> createState() => _SubjectsManagementState();
}

class _SubjectsManagementState extends State<SubjectsManagement> {
  final ClassController _classController = Get.find();
  final SubjectController _subjectController = Get.put(SubjectController());
  final TextEditingController _subNameController = TextEditingController();
  var _selectedClass;
  int? _selectedClassId;
  bool _showSubjectList = false;
  bool? isSwitched = false;

  @override
  void initState() {
    super.initState();
    if (_classController.deptClasses.isEmpty) {
      getClasses();
    }
  }

  getClasses() async {
    await _classController.getAllClasses();

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
      appBar: appbar('Subjects & Practicals Management', context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45.0),
              child: Row(
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
                          _subjectController.subByClass.clear();
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent),
                      onPressed: () async {
                        if (_selectedClass != null) {
                          await _subjectController
                              .getSubjectByClass(_selectedClass);
                        }
                      },
                      child: const Text('submit'))
                ],
              ),
            ),
            _selectedClass == null
                ? Container()
                : Text('All Subject of class $_selectedClass'),
            _selectedClass == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(width: 0.6)),
                      padding: const EdgeInsets.all(28),
                      child: Obx(() => (_subjectController.subByClass.isEmpty
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _subjectController.subByClass.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(_subjectController
                                            .subByClass[index].name
                                            .toString()),
                                        IconButton(
                                            onPressed: () async {
                                              String res =
                                                  await _subjectController
                                                      .deleteSubject(
                                                          _subjectController
                                                              .subByClass[index]
                                                              .subId);
                                              DisplayMessage.showMsg(res);
                                              if (res == "Subject Deleted") {
                                                _subjectController.subByClass
                                                    .remove(_subjectController
                                                        .subByClass[index]);
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
                              }))),
                    ),
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is It Practical?'),
                Checkbox(
                  value: isSwitched,
                  onChanged: (bool? value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),
              ],
            ), //Check
            CustomButton(
              msg: 'Add Subject',
              icon: Icons.add,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog(
                        controller: _subNameController,
                        label: 'Enter Subject Name:',
                        onTap: () {
                          addSubject(context);
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

  Future addSubject(BuildContext context) async {
    if (_subNameController.text.isNotEmpty && _selectedClass != null) {
      sub.Subject subj =
          sub.Subject(name: _subNameController.text, isPractical: isSwitched);

      sub.Subject? addedSub =
          await _subjectController.addSubject(subj, _selectedClass);
      if (addedSub != null) {
        DisplayMessage.showMsg('Subject Added');

        _subjectController.subByClass.add(addedSub);
        Navigator.of(context).pop();
      }
    } else {
      DisplayMessage.showMsg('Please Select class first  & then enter subject');
    }
  }
}
