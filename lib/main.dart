import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instattendance_admin/utils/storage_utils.dart';
import 'package:instattendance_admin/view/autentication_view/admin_auth.dart';
import 'package:instattendance_admin/view/homepage_view/home.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.indigoAccent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: GoogleFonts.titilliumWeb().fontFamily,
          primarySwatch: Colors.blue,
          primaryColorLight: Colors.indigoAccent),
      home: showScreen(),
    );
  }

  showScreen() {
    StorageUtil storage = StorageUtil.storageInstance;
    String? email = storage.getPrefs('email');
    String? password = storage.getPrefs('password');

    if (email!.isEmpty && password!.isEmpty) {
      return AuthenticationView();
    } else {
      return const HomePage();
    }
  }
}
