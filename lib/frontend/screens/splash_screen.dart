import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihusishe/frontend/screens/dashboard.dart';

import '../../backend/controllers/auth_controller.dart';
import '../auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        ()  {
          if(AuthController.to.parseUser.value!=null){
            Get.offAll(()=>const DashBoard());
          }else{
            Get.offAll(()=>const Login());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Center(
        child: Image.asset('images/jihusishe-logo.png'),
      ),
    );
  }
}