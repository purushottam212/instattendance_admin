import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/models/student1.dart';
import 'package:instattendance_admin/models/student_model.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class AddStudentForm extends StatelessWidget {
  AddStudentForm(
      {Key? key, required this.selectedClass, required this.selectedDiv})
      : super();
  final StudentController _studentController = Get.find();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _prnController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final String selectedClass;
  final String selectedDiv;
  @override
  Widget build(BuildContext context) {
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
              CustomButton(
                msg: 'Add Student',
                icon: Icons.add,
                onTap: () async {
                  await addStudent();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addStudent() async {
    if (_nameController.text.isNotEmpty &&
        _prnController.text.isNotEmpty &&
        _rollController.text.isNotEmpty) {
      StudentClass sc = StudentClass(className: selectedClass, students: []);
      print(sc.className);
      print(selectedClass);
      print(selectedDiv);

      StudentDivision sd =
          StudentDivision(divisionName: selectedDiv, students: []);
      print(sd.divisionName);
      Student s1 = Student(
          prnNo: _prnController.text,
          rollNo: _rollController.text,
          name: _nameController.text,
          studentClass: StudentClass(className: selectedClass, students: []),
          studentDivision: sd);

      Student? addStud = await _studentController.addStudent(s1);
      if (addStud != null) {
        Student1 addedStud =
            Student1(prnNo: s1.prnNo, rollNo: s1.rollNo, name: s1.name);
        _studentController.studentsByClassAndDiv.add(addedStud);

        DisplayMessage.showMsg('student added');
      }
    }
  }
}
