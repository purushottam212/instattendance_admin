import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/controller/division_controller.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/widget/drawer_navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StudentController _studentController = Get.put(StudentController());
  final ClassController _classController = Get.put(ClassController());
  final DivisionController _divisionController = Get.put(DivisionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Admin Panel"),
        ),
        body: const Center(child: Center(child: Text("This is Home page"))),
        drawer: const NavDrawer());
  }
}
