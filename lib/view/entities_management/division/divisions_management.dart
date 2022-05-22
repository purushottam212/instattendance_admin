import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instattendance_admin/controller/division_controller.dart';
import 'package:instattendance_admin/models/division_model.dart';
import 'package:instattendance_admin/widget/alert_dialog.dart';
import 'package:instattendance_admin/widget/common_appbar.dart';
import 'package:instattendance_admin/widget/custom_button.dart';
import 'package:instattendance_admin/widget/show_toast.dart';

class DivisionsManagement extends StatelessWidget {
  DivisionsManagement({Key? key}) : super(key: key);
  final DivisionController _divController = Get.find();
  final TextEditingController _divNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Divisions Management', context),
      body: FutureBuilder(
        future: _divController
            .getAllDivisions(), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // AsyncSnapshot<Your object type>
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Please wait its loading...'));
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('All Availabel Divisions of Classes'),
                      Container(
                        decoration:
                            BoxDecoration(border: Border.all(width: 0.6)),
                        padding: const EdgeInsets.all(28),
                        child: Obx(() => (_divController.divisions.isEmpty
                            ? const Center(
                                child: Text(
                                    'Divisions are not added yet,,add division by hitting below button'),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: _divController.divisions.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(_divController
                                              .divisions[index].divisionName
                                              .toString()),
                                          IconButton(
                                              onPressed: () async {
                                                String res =
                                                    await _divController
                                                        .deleteDivision(
                                                            _divController
                                                                .divisions[
                                                                    index]
                                                                .id);
                                                DisplayMessage.showMsg(res);
                                                if (res == "Deleted Division") {
                                                  _divController.divisions
                                                      .remove(_divController
                                                          .divisions[index]);
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
                      CustomButton(
                        msg: 'Add Division',
                        icon: Icons.add,
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  controller: _divNameController,
                                  label: 'Enter Division Name:',
                                  onTap: () async {
                                    addDivision(context);
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
          }
        },
      ),
    );
  }

  Future addDivision(BuildContext context) async {
    if (_divNameController.text.isNotEmpty) {
      Division addDivision = Division(divisionName: _divNameController.text);
      Division? addedDiv = await _divController.addDivision(addDivision);
      if (addedDiv != null) {
        DisplayMessage.showMsg('Division ${_divNameController.text} added');
        _divController.divisions.add(addedDiv);
        Navigator.of(context).pop();
      }
    }
  }
}
