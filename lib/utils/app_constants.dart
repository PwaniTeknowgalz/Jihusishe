// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppConst{
  //App main colors
  static const Color mainColor = Color.fromRGBO(3,167,155, 1);
  static const Color mainColorLight = Color.fromRGBO(10,181,158, 1);
  static const Color secColor = Color.fromRGBO(206, 83, 107, 1);
  static const Color secColorLight = Color.fromRGBO(247,230,176, 1);
  static const Color accentColor = Color.fromRGBO(51,65,72, 1);
  static const Color splashBg = Color.fromRGBO(28, 142, 153, 1);
  static const Color customColor =  Color.fromRGBO(22, 29, 64, 1);

  //Snackbar Colors
  static const Color success = Color.fromRGBO(40, 167, 69, 1);
  static const  Color error = Color.fromRGBO(220, 53, 80, 1.0);
  static const Color warning = Color.fromRGBO(255,193,7, 1.0);
  static const Color info = Color.fromRGBO(28, 162, 184, 1);

  //Custom button style
  static ButtonStyle buttonStyle = TextButton.styleFrom(
    minimumSize: Size(double.infinity, 40),
    primary: Colors.white,
    backgroundColor: secColor,
    textStyle: TextStyle(fontWeight: FontWeight.bold, letterSpacing: .5, fontSize: 15),
    padding: EdgeInsets.symmetric(horizontal: 18.0,  vertical: 15),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    ),
  );
}