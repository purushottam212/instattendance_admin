import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/practical_batch_controller.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/models/practical_batch_model.dart';
import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/models/student_model.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/selection_box_widget.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class AddStudentForm extends StatefulWidget {
  AddStudentForm(
      {Key? key, required this.selectedClass, required this.selectedDiv})
      : super();
  final String selectedClass;
  final String selectedDiv;

  @override
  State<AddStudentForm> createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final StudentController _studentController = Get.find();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _prnController = TextEditingController();

  final TextEditingController _rollController = TextEditingController();

  final PracticalBatchController _practicalBatchController = Get.find();

  String selectedBatch = '';
  @override
  void initState() {
    getPracticalBatches();
    super.initState();
  }

  getPracticalBatches() async {
    await _practicalBatchController.getPracticalBatches(
        widget.selectedClass, widget.selectedDiv);
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
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.name,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _prnController,
                  decoration: InputDecoration(
                    labelText: "Enter PRN No:",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  //keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _rollController,
                  decoration: InputDecoration(
                    labelText: "Enter Roll No:",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  //keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                    child: SelectionBox(
                      height: height,
                      width: width,
                      child: DropdownButton<PracticalBatch>(
                        hint: selectedBatch == ''
                            ? const Text(
                                'select Batch',
                                style: TextStyle(fontSize: 12),
                              )
                            : Text(selectedBatch.toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                        items: _practicalBatchController.batchList.isEmpty
                            ? null
                            : _practicalBatchController.batchList
                                .map((PracticalBatch value) {
                                return DropdownMenuItem<PracticalBatch>(
                                  value: value,
                                  child: Text(value.batchName.toString()),
                                );
                              }).toList(),
                        onChanged: (batch) {
                          setState(() {
                            selectedBatch = batch!.batchName.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                msg: 'Add Student',
                icon: Icons.add,
                onTap: () async {
                  await addStudent(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addStudent(BuildContext context) async {
    if (_nameController.text.isNotEmpty &&
        _prnController.text.isNotEmpty &&
        _rollController.text.isNotEmpty) {
      StudentClass sc =
          StudentClass(className: widget.selectedClass, students: []);
      print(sc.className);
      print(widget.selectedClass);
      print(widget.selectedDiv);
   
      StudentDivision sd =
          StudentDivision(divisionName: widget.selectedDiv, students: []);
      print(sd.divisionName);
      Student s1 = Student(
          prnNo: _prnController.text,
          rollNo: _rollController.text,
          name: _nameController.text,
          practicalBatch: selectedBatch,
          studentClass:
              StudentClass(className: widget.selectedClass, students: []),
          studentDivision: sd);

      Student? addStud = await _studentController.addStudent(s1);
      if (addStud != null) {
        Student1 addedStud =
            Student1(prnNo: s1.prnNo, rollNo: s1.rollNo, name: s1.name);
        _studentController.studentsByClassAndDiv.add(addedStud);

        DisplayMessage.showMsg('student added');
        Navigator.of(context).pop();
      }
    } else {
      DisplayMessage.showMsg('All Fields Are Required');
    }
  }
}
