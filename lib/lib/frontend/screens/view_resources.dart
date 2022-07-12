import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/backend/controllers/main_controller.dart';
import 'package:jihusishe/lib/utils/app_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/app_constants.dart';

class ViewResources extends StatefulWidget {
  const ViewResources({Key? key}) : super(key: key);

  @override
  State<ViewResources> createState() => _ViewResourcesState();
}

class _ViewResourcesState extends State<ViewResources> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      width: Get.width,
                      height: Get.height * .3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider((MainController
                                      .to.selectedResource.value
                                      ?.get("image") as ParseFile)
                                  .url ??
                              "http://via.placeholder.com/350x150"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4), BlendMode.darken),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          SizedBox(height: Get.height * .1),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "${MainController.to.selectedResource.value?.get("title")}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "${MainController.to.selectedResource.value?.get("content")}",
                        style: const TextStyle(height: 1.4, letterSpacing: .2),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          "Comments(${MainController.to.selectedResource.value?.get("comments") == null ? 0 : MainController.to.selectedResource.value?.get("comments").length}): ",
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 12),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return _showComments();
                    })
                  ]),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 5, left: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                name: 'comment',
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintText: "Write a comment..."),
                                // onChanged: _onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            await _saveComment(_formKey.currentState);
                          },
                          child: const Icon(Icons.send))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            heroTag: "Share",
            onPressed: () {
              Share.share(
                  "${MainController.to.selectedResource.value?.get("title")}  ${MainController.to.selectedResource.value?.get("link")}  -> Shared Via Jihusishe App");
            },
            backgroundColor: const Color.fromRGBO(22, 29, 64, 1),
            child: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ),
        //     MainController.to.selectedResource.value?.get("link") != null &&
        //             MainController.to.selectedResource.value?.get("link") != ""
        //         ? Container(
        //             width: Get.width - 30,
        //             padding: EdgeInsets.only(bottom: 60),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 FloatingActionButton.extended(
        //                   heroTag: "ViewMore",
        //                   onPressed: () {
        //                     MainController.to.openUrl(
        //                         "${MainController.to.selectedResource.value?.get("link")}");
        //                   },
        //                   backgroundColor: const Color.fromRGBO(22, 29, 64, 1),
        //                   label: Text("View More"),
        //                   icon: const Icon(
        //                     Icons.remove_red_eye_sharp,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 FloatingActionButton(
        //                   heroTag: "Share",
        //                   onPressed: () {
        //                     Share.share(
        //                         "${MainController.to.selectedResource.value?.get("title")}  ${MainController.to.selectedResource.value?.get("link")}  -> Shared Via Jihusishe App");
        //                   },
        //                   backgroundColor: const Color.fromRGBO(22, 29, 64, 1),
        //                   child: const Icon(
        //                     Icons.share,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )
        //         : null,
      ),
    );
  }
}

_showComments() {
  var comments = MainController.to.selectedResource.value?.get("comments");
  print(comments);
  if (comments == null) {
    return Container();
  }
  comments = (comments as List).reversed.toList();
  return Column(
    children: comments.map<Widget>((e) {
      return Container(
        width: Get.width,
        alignment: AlignmentDirectional.centerStart,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${e["author"]["name"].trim()}",
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("${e["content"].trim()}", style: const TextStyle()),
            const SizedBox(
              height: 10,
            ),
            Text("${e["createdAt"].trim()}",
                style: const TextStyle(
                  fontSize: 8,
                )),
          ],
        ),
      );
    }).toList(),
  );
}

_saveComment(FormBuilderState? currentState) async {
  //AppUtils.showLoading();
  //print("TTTT");
  if (currentState != null) {
    currentState.save();
    print(currentState.value);
  }
  if (currentState == null || !currentState.isValid) {
    AppUtils.showError("Entered data is invalid or fields are empty!");
    return;
  }

  var comment = currentState.value["comment"];

  await MainController.to.addComment(content: comment);

  SmartDialog.dismiss();

  currentState.reset();
}
