import 'package:flutter/material.dart';

class SelectionBox extends StatelessWidget {
  const SelectionBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.child})
      : super(key: key);
  final double height;
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const Text('Class:'),
        const SizedBox(width: 20),
        Container(
          height: height * 0.07,
          width: width * 0.33,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(child: child),
        ),
      ],
    );
  }
}
