import 'package:flutter/material.dart';
import 'package:instattendance_admin/widget/custom_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {Key? key, required this.controller, required this.label, this.onTap})
      : super(key: key);
  final TextEditingController controller;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        actions: [
          SingleChildScrollView(
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: label,
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
                  CustomButton(msg: 'Done ', icon: Icons.done, onTap: onTap)
                ],
              ),
            ),
          ),
        ]);
  }
}
