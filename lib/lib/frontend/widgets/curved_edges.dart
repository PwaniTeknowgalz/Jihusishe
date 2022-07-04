import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurvedEdges extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final Widget top;
  final Widget bottom;
  final double topHeight;
  final double radius;
  const CurvedEdges({Key? key, required this.topColor, required this.bottomColor, required this.top, required this.bottom, required this.topHeight, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: topColor,
      child: Column(
        children: [
          Container(
            height: topHeight,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                  top:0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    color:bottomColor ,
                  )
                ),
            Positioned(
              top:0,
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(radius)),
                  color: topColor,

                ),

                padding:EdgeInsets.symmetric(vertical:radius,horizontal: radius ),
                child: top,
              ),)
              ],
            ),
          ),
          Container(
            height: Get.height-topHeight,
            width: Get.width,
            child: Stack(
              children: [
                Positioned(
                    top:0,
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      color:topColor ,
                    )
                ),
                Positioned(
                  top:0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(radius)),
                      color: bottomColor
                    ),
                    padding:EdgeInsets.symmetric(vertical:radius,horizontal: radius ),
                    child: bottom,
                  ),)
              ],
            ),
          )

        ],
      ),
    );
  }
}
