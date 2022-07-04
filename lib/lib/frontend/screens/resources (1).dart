import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/frontend/screens/view_resources.dart';

class Resources extends StatelessWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(22, 29, 64, 1),
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
          title: Text("Resources"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 70,
              child: Container(
                width: Get.width,
                height: Get.height - 70,
                child: ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    //list item
                    InkWell(
                      onTap: () {
                        Get.to(() => ViewResources());
                      },
                      child: Container(
                        width: Get.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey[300]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  image: DecorationImage(
                                      image: AssetImage("images/report.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                              child: Text(
                                "How to detect an unusual login attempt",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    //end of list item
                    SizedBox(
                      height: 16,
                    ),
                    //list item
                    Container(
                      width: Get.width,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey[300]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                image: DecorationImage(
                                    image: AssetImage("images/resource.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Text(
                              "Please turn on 2 factor authentication to secure your apps from hacking",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    //end of list item
                  ],
                ),
              ),
            ),
            //social icons
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Image(
                          image: AssetImage("images/facebook.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image(
                          image: AssetImage("images/twitter.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image(
                          image: AssetImage("images/instagram.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Image(
                          image: AssetImage("images/linkedin.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
