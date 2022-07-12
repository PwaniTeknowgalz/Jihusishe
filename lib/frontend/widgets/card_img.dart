import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardImg extends StatelessWidget {
  const CardImg(
      {Key? key,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.onClick})
      : super(key: key);
  final String img, title, subtitle;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Stack(
        children: [
          Container(
            height: Get.height * .5 - 48,
            width: Get.width,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
          ),
          Container(
            height: Get.height * .5 - 48,
            width: Get.width,
            decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, .7)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 2.5,
                  width: 30,
                  child: Container(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(subtitle, style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
