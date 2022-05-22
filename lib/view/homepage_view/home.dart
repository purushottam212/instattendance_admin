import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/class_controller.dart';
import 'package:instattendance_admin/controller/division_controller.dart';
import 'package:instattendance_admin/controller/notification_controller.dart';
import 'package:instattendance_admin/controller/student_controller.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/drawer_navigation.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StudentController _studentController = Get.put(StudentController());
  final ClassController _classController = Get.put(ClassController());
  final DivisionController _divisionController = Get.put(DivisionController());
  final NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  getNotifications() async {
    await _notificationController.getAllNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar('Admin Panel', context),
        drawer: const NavDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            await _notificationController.getAllNotification();
          },
          child: ListView(children: [
            Column(children: [
              const SizedBox(
                height: 35,
              ),
              const Text('Notification View'),
              const Divider(
                color: Colors.grey,
                thickness: 1.3,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => _notificationController.notificationsList.isEmpty
                    ? const Center(
                        child: Text('No Notifications At Moment'),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            _notificationController.notificationsList.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            childrenPadding: const EdgeInsets.all(12),
                            title: Text(
                                "${_notificationController.notificationsList[index].date}"),
                            children: [
                              Text(
                                  "send by :  ${_notificationController.notificationsList[index].teacher}"),
                              Text(
                                  "sender email:   ${_notificationController.notificationsList[index].teacherEmail}"),
                              Text(
                                  "message : ${_notificationController.notificationsList[index].message}"),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                    onPressed: () async {
                                      var deleted =
                                          await _notificationController
                                              .deleteNotification(
                                                  _notificationController
                                                      .notificationsList[index]
                                                      .id!);
                                      DisplayMessage.showMsg(
                                          deleted.toString());

                                      _notificationController.notificationsList
                                          .remove(_notificationController
                                              .notificationsList[index]);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: 15,
                                    )),
                              )
                            ],
                          );
                        }),
              )
            ])
          ]),
        ));
  }
}
