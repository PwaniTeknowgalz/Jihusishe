import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/utils/app_constants.dart';

import 'countieslist.dart';

class Police extends StatelessWidget {
  const Police({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(children: [
          //Header
          Container(
            height: 94,
            width: Get.width,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              color: Color.fromRGBO(22, 29, 64, 1),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                SizedBox(width: Get.width * .18),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SizedBox(height: 10),
                      Text(
                        "Mombasa Police Centers!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Tap for more actions",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              ListTile(
                title: Text("Makupa Police Station"),
                subtitle: Text("EXM55+65J, Mombasa Road"),
                onTap: () {
                  _settingModalBottomSheet(context);
                },
              ),
              Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              ListTile(
                title: Text("The Kenya Police - Changamwe Station"),
                subtitle: Text(
                    "XJFJ+RJ8 Opposite Changamwe Post Office, Magongo Road, Mombasa"),
                onTap: () {
                  _settingModalBottomSheet(context);
                },
              ),
              Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              ListTile(
                title: Text("Nyali Police Station"),
                subtitle: Text("WMXV+27F,Moyne Dr,Mombasa"),
                onTap: () {
                  _settingModalBottomSheet(context);
                },
              ),
            ],
          ))
        ]),
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.call,color: AppConst.secColor,),
                  title: new Text('Call'),
                  onTap: () => {}),
                  Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              new ListTile(
                leading: new Icon(Icons.message, color: AppConst.secColor,),
                title: new Text('Send Message'),
                onTap: () => {},
                
              ),Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),

              new ListTile(
                leading: new Icon(Icons.record_voice_over, color: AppConst.secColor,),
                title: new Text('Record'),
                onTap: () => {},
              ),
              Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              new ListTile(
                leading: new Icon(Icons.map, color: AppConst.secColor,),
                title: new Text('Direction'),
                onTap: () => {},
              ),
            ],
          ),
        );
      });
}
