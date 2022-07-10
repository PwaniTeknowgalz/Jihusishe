// ignore_for_file: prefer_const_constructors

import 'dart:ui';

//import 'package:data4peace/utils/app_constants.dart';
//import 'package:data4peace/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/backend/controllers/auth_controller.dart';
import 'package:jihusishe/lib/frontend/auth/login.dart';
import 'package:jihusishe/lib/frontend/screens/dashboard.dart';
import 'package:jihusishe/lib/frontend/widgets/curved_edges.dart';
import 'package:jihusishe/lib/frontend/widgets/custom_button.dart';
//import 'package:jihusishe/lib/frontend/widgets/curved_button.dart';
//import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppConst.mainColor,
      body: Container(
        width: Get.size.width,
        height: Get.size.height,
        child: Column(
          children: [
            //Custom Widget that handles the curves
            CurvedEdges(

                //Height of the top part
                topHeight: 250,

                //Radius of the curves
                radius: 50,

                //Top section background color
                topColor: Colors.white,

                //Bottom section background color
                bottomColor: Color.fromRGBO(22, 29, 64, 1),

                //Top section widget
                top: Image.asset("images/image2.png",
                    height: Get.size.height * 0.4,
                    width: Get.size.height * 0.4),

                //Bottom section Widget
                bottom: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "JIHUSISHE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your security is our concern \nUsalama wako, jukumu letu",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // Text("Usalama wako, jukumu letu",
                    //     style: TextStyle(
                    //         color: Colors.white70,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500)),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    CustomButton(
                        title: "Welcome",
                        onPressed: () {

                          if(AuthController.to.parseUser.value==null){

                            Get.to(() => Login());
                          }else{

                            Get.to(() => DashBoard());
                          }

                        }),

                    SizedBox(
                      height: 25,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
