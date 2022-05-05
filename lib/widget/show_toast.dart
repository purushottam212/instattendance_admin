import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DisplayMessage {
  static showMsg(String msg) {
    return Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);
  }
}
