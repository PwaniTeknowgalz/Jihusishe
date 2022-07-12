import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jihusishe/backend/controllers/main_controller.dart';
import 'package:jihusishe/utils/app_constants.dart';
import 'package:jihusishe/utils/data.dart';
import 'package:jihusishe/frontend/widgets/audio_recorder.dart';
import 'package:share_plus/share_plus.dart';
import 'countieslist.dart';

class Police extends StatefulWidget {
  final county;

  const Police({Key? key, required this.county}) : super(key: key);

  @override
  State<Police> createState() => _PoliceState();
}

class _PoliceState extends State<Police> {


  @override
  void initState() {
    Future.microtask(() => MainController.to.showPlayer.value = false);
    super.initState();
  }
  final GlobalKey<ScaffoldState> drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var data = Data.policestations[widget.county];

    return Obx(() => MainController.to.showPlayer.value
        ? AudioRecorder(
      onStop: (path) {
        if (kDebugMode) print('Recorded file path: $path');
          MainController.to.audioPath.value = path;
          MainController.to.showPlayer.value = false;
        if(MainController.to.audioPath.value!=""){
          Share.shareFiles([MainController.to.audioPath.value], text: 'I would like to report a crime via this audio');
        }
      },
    )
        : Scaffold(
      key: drawerKey,
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(22, 29, 64, 1),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ))
          ],
          title: const ListTile(
            title: Text(
              "Mombasa Police Centers!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Tap for more actions",
              style: TextStyle(
                color: Colors.white60,
                fontSize: 12,
              ),
            ),
          )),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Column(children: [
          //Header
          // Container(
          //   height: 94,
          //   width: Get.width,
          //   decoration: const BoxDecoration(
          //     // borderRadius: BorderRadius.only(
          //     //     bottomLeft: Radius.circular(30),
          //     //     bottomRight: Radius.circular(30)),
          //     color: Color.fromRGBO(22, 29, 64, 1),
          //   ),
          //   child: Row(
          //     children: [
          //       const SizedBox(width: 10),
          //       SizedBox(width: Get.width * .18),
          //       Container(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: const [
          //             SizedBox(height: 10),
          //             Text(
          //               "Mombasa Police Centers!",
          //               style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold),
          //             ),
          //             SizedBox(height: 5),
          //             Text(
          //               "Tap for more actions",
          //               style: TextStyle(
          //                 color: Colors.white60,
          //                 fontSize: 12,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var policestation = data[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(policestation["name"]),
                        subtitle: Text(policestation["location"]),
                        onTap: () {
                          _settingModalBottomSheet(context, policestation);
                        },
                      ),
                      const Divider(
                        thickness: 0.2,
                        color: Color.fromARGB(255, 205, 211, 239),
                      ),
                    ],
                  );
                },
              ))
        ]),

      ),
    ));
  }
}

void _settingModalBottomSheet(context, policestation) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.call,
                    color: AppConst.secColor,
                  ),
                  title: const Text('Call'),
                  onTap: () async {
                    Get.back();
                    MainController.to.openUrl("tel:${policestation["phone"]}");
                  }),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              ListTile(
                leading: const Icon(
                  Icons.message,
                  color: AppConst.secColor,
                ),
                title: const Text('Send Message'),
                onTap: () {
                  Get.back();
                  MainController.to.openUrl("sms:${policestation["phone"]}");
                },
              ),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              ListTile(
                leading: const Icon(
                  Icons.record_voice_over,
                  color: AppConst.secColor,
                ),
                title: const Text('Record'),
                onTap: () {
                  Get.back();
                  MainController.to.showPlayer.value = true;

                },
              ),
              const Divider(
                thickness: 0.2,
                color: Color.fromARGB(255, 205, 211, 239),
              ),
              ListTile(
                leading: const Icon(
                  Icons.map,
                  color: AppConst.secColor,
                ),
                title: const Text('Direction'),
                onTap: () => {
                  MainController.to.openUrl("https://www.google.com/maps/dir/?api=1&destination=${Uri.encodeFull(policestation["name"])}")
                },
              ),
            ],
          ),
        );
      });
}
