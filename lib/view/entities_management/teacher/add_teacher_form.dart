import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';

import 'package:instattendance_admin/controller/teacher_contoller.dart';
import 'package:instattendance_admin/models/teacher_model.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class AddTeacherForm extends StatelessWidget {
  AddTeacherForm({Key? key}) : super(key: key);
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _rolesController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TeacherController _teacherController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Enter Teacher Name",
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Enter Teacher Email",
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
                  controller: _designationController,
                  decoration: InputDecoration(
                    labelText: "Enter Teacher Designation",
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
                  controller: _rolesController,
                  decoration: InputDecoration(
                    labelText: "Enter Teacher Roles",
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Enter Teacher Password",
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
              CustomButton(
                msg: 'Submit',
                icon: Icons.done,
                onTap: () async {
                  await addTeacher(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addTeacher(BuildContext context) async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _designationController.text.isNotEmpty &&
        _rolesController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        emailValid) {
      List<dynamic> rolesList = _rolesController.text.split(",");

      List<Role> roleList = List.empty(growable: true);

      for (var i = 0; i < rolesList.length; i++) {
        roleList.add(Role(roleName: rolesList[i], teachers: []));
      }
      Teacher t = Teacher(
          name: _nameController.text,
          email: _emailController.text,
          designation: _designationController.text,
          password: _passwordController.text,
          roles: roleList);

      Teacher? addedTeacher = await _teacherController.addTeacher(t);
      if (addedTeacher != null) {
        DisplayMessage.showMsg('Teacher Added');
        Navigator.of(context).pop();
        _teacherController.teachersList.add(addedTeacher);
        await sendEmailToTeacher();
      }
    } else {
      DisplayMessage.showMsg('Check All Fields Properly');
    }
  }

  Future<void> sendEmailToTeacher() async {
    final Email email = Email(
      body:
          'Your Password for Instattendance App\n Email : ${_emailController.text}, Password: ${_passwordController.text} ',
      subject: 'Instattendance Credentials',
      recipients: [_emailController.text],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      DisplayMessage.showMsg('Email Send to Teacher ${_nameController.text}');
    } catch (error) {
      print(error);
      DisplayMessage.showMsg(error.toString());
    }
  }
}
