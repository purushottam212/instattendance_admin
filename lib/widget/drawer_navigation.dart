import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instattendance_admin/models/practical_batch_model.dart';
import 'package:instattendance_admin/view/entities_management/class/classes_management.dart';
import 'package:instattendance_admin/view/entities_management/division/divisions_management.dart';
import 'package:instattendance_admin/view/entities_management/student/student_management.dart';
import 'package:instattendance_admin/view/entities_management/subject/subject_management.dart';
import 'package:instattendance_admin/view/entities_management/teacher/teacher_management.dart';
import 'package:instattendance_admin/view/homepage_view/home.dart';
import 'package:instattendance_admin/view/pratical_batch_management/batches_page.dart';
import 'package:instattendance_admin/view/settings_view/settings.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
            ),
            child: Center(
              child: Row(
                children: const [
                  Center(
                    child: Text(
                      "Instattendance Admin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const HomePage()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Manage Students"),
            leading: IconButton(
              icon: const Icon(Icons.people_alt_outlined),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const StudentManagement()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Manage Teachers"),
            leading: IconButton(
              icon: const Icon(Icons.person_outline_sharp),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => TeachersManagement()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Manage Classes"),
            leading: IconButton(
              icon: const Icon(Icons.class__rounded),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ClassesManagement()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Manage Divisions"),
            leading: IconButton(
              icon: const Icon(Icons.design_services_outlined),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => DivisionsManagement()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Manage Subjects & Practicals"),
            leading: IconButton(
              icon: const Icon(Icons.subject_sharp),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const SubjectsManagement()));
            },
          ),
           const Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: const Text("Batches Management"),
            leading: IconButton(
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>const PracticalBatchPage()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
        
          ListTile(
            title: const Text("Settings"),
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
            },
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
