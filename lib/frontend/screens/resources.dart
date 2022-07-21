import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jihusishe/backend/controllers/main_controller.dart';
import 'package:jihusishe/frontend/screens/view_resources.dart';
import 'package:jihusishe/frontend/widgets/custom_button.dart';
import 'package:jihusishe/frontend/widgets/side_navigation.dart';
import 'package:jihusishe/utils/app_constants.dart';
import 'package:jihusishe/utils/app_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';

class Resources extends StatefulWidget {
  const Resources({Key? key}) : super(key: key);

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  @override
  initState(){

    super.initState();
    Future.microtask(() async {
      await MainController.to.fetchResourcesData();
    });
  }
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      drawer: AppDrawerWidget().getDrawer("resources"),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom:40.0),
      //   child: FloatingActionButton(onPressed: (){
      //     _showEditDialog(null);
      //   },child: const Icon(Icons.add)),
      // ),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(22, 29, 64, 1),
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: const Text("Resources"),
          actions:  [
            IconButton(
                onPressed: () async {
                  await MainController.to.fetchResourcesData();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                ))
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              bottom: 70,
              child: Container(
                width: Get.width,
                height: Get.height - 90,
                child:Obx(() {
                  var resources = MainController.to.resources;
                  return ListView.builder(
                    itemCount: resources.length,
                    itemBuilder: (context, index) {
                      var resource = resources[resources.keys.toList()[index]];
                      print(resource);
                    return  Padding(
                      padding: const EdgeInsets.only(bottom:10.0, right: 20,left: 20),
                      child: InkWell(
                        onTap: () {
                          MainController.to.selectedResource.value = resource;
                          Get.to(() => const ViewResources());
                        },
                        child: Container(
                          width: Get.width,
                          padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Container(
                              //                               //   width: 70,
                              //                               //   height: 70,
                              //                               //   decoration: const BoxDecoration(
                              //                               //       borderRadius:
                              //                               //       BorderRadius.all(Radius.circular(5)),
                              //                               //       ),
                              //                               //   child: CachedNetworkImage(
                              //                               //     imageUrl: ((resource as ParseObject).get("image") as ParseFile).url??"http://via.placeholder.com/350x150",
                              //                               //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                              //                               //         CircularProgressIndicator(value: downloadProgress.progress),
                              //                               //     errorWidget: (context, url, error) => const Icon(Icons.error),
                              //                               //   ),
                              //                               // ),
                            Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(5)),
                                            image: DecorationImage(
                                                image: CachedNetworkImageProvider(((resource as ParseObject).get("image") as ParseFile).url??"http://via.placeholder.com/350x150"),
                                                fit: BoxFit.cover)),
                                      ),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                child: Text(
                                  "${resource.get("title")}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                              ),
                              // IconButton(onPressed: (){
                              //   _showEditDialog(resource);
                              // }, icon: const Icon(Icons.edit))
                            ],
                          ),
                        ),
                      ),
                    );
                  },);
                },
                ),
                // ListView(
                //   padding: EdgeInsets.all(16),
                //   shrinkWrap: true,
                //   children: [
                //     //list item
                //
                //     //end of list item
                //     SizedBox(
                //       height: 16,
                //     ),
                //     //list item
                //     Container(
                //       width: Get.width,
                //       padding:
                //           EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(5)),
                //           color: Colors.grey[300]),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Container(
                //             width: 70,
                //             height: 70,
                //             decoration: BoxDecoration(
                //                 borderRadius:
                //                     BorderRadius.all(Radius.circular(5)),
                //                 image: DecorationImage(
                //                     image: AssetImage("images/resource.jpg"),
                //                     fit: BoxFit.cover)),
                //           ),
                //           SizedBox(
                //             width: 7,
                //           ),
                //           Expanded(
                //             child: Text(
                //               "Please turn on 2 factor authentication to secure your apps from hacking",
                //               maxLines: 2,
                //               overflow: TextOverflow.ellipsis,
                //               style: TextStyle(
                //                   fontSize: 15, fontWeight: FontWeight.w500),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //     //end of list item
                //   ],
                // ),
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
                        onTap: () {
                          MainController.to.openUrl("https://facebook.com/groups/1128692297856610/");
                        },
                        child: const Image(
                          image: AssetImage("images/facebook.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          
                          MainController.to.openUrl("https://twitter.com/Jihusishe_App?t=KnoQUoZ-WZc6GqqAtHh7Qw&s=08");
                        },
                        child: const Image(
                          image:  AssetImage("images/twitter.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                           MainController.to.openUrl("https://www.instagram.com/jihusishe/");
                        },
                        child: const Image(
                          image: AssetImage("images/instagram.png"),
                          height: 36,
                          width: 36,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          MainController.to.openUrl("https://www.instagram.com/jihusishe/");
                        },
                        child: const Image(
                          image:  AssetImage("images/linkedin.png"),
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

  // void _onChanged (text){
  //
  // }

  // void _showAddDialog() {
  //   MainController.to.image.value="";
  //   SmartDialog.show(builder: (context) {
  //     return SafeArea(
  //       child: Container(
  //         color: Colors.white,
  //
  //         child: Column(
  //           children: [
  //             Container(
  //
  //               color: const Color.fromRGBO(22, 29, 64, 1),
  //               child: Obx(() {
  //                 return ListTile(
  //                   contentPadding: const EdgeInsets.only(left: 20,right:0,top: 5,bottom: 5),
  //                   tileColor: const Color.fromRGBO(22, 29, 64, 1),
  //                   trailing: IconButton(onPressed: (){
  //                     SmartDialog.dismiss();
  //                   }, icon: const Icon(Icons.close,color: Colors.white,)),
  //                   title:MainController.to.selectedResource.value==null?const Text("Add Resource", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)):const Text("Edit Resource", style: TextStyle(color: Colors.white)),
  //                   subtitle: const Text("Enter Details below", style: TextStyle(color: Colors.white),),
  //                 );
  //               }
  //               ),
  //             ),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 20),
  //               child: FormBuilder(
  //                 key: _formKey,
  //                 autovalidateMode: AutovalidateMode.disabled,
  //                 child: Column(
  //                   children: <Widget>[
  //                     const SizedBox(height: 30,),
  //                     FormBuilderTextField(
  //                       name: 'title',
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //                         labelText:
  //                         'Title',
  //                       ),
  //                       onChanged: _onChanged,
  //                       // valueTransformer: (text) => num.tryParse(text),
  //                       validator: FormBuilderValidators.compose([
  //                         FormBuilderValidators.required(),
  //                       ]),
  //                       keyboardType: TextInputType.text,
  //                     ),
  //                     const SizedBox(height: 20,),
  //                     FormBuilderTextField(
  //                       name: 'content',
  //                       minLines: 4,
  //                       maxLines: 8,
  //                       decoration:  InputDecoration(
  //                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //                         labelText:
  //                         'Content',
  //                       ),
  //                       onChanged: _onChanged,
  //                       // valueTransformer: (text) => num.tryParse(text),
  //                       validator: FormBuilderValidators.compose([
  //                         FormBuilderValidators.required(),
  //                       ]),
  //                       keyboardType: TextInputType.text,
  //                     ),
  //                     const SizedBox(height: 20,),
  //                     Obx(() => InkWell(
  //                       onTap: () async {
  //                         final ImagePicker _picker = ImagePicker();
  //                         var file  = await _picker.pickImage(source: ImageSource.gallery);
  //                         if(file!=null){
  //                           MainController.to.image.value=file.path;
  //                           //print(MainController.to.image.value?.path);
  //                         }
  //                       },
  //                       child: Container(
  //                         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
  //                         decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.black38),
  //                             borderRadius: BorderRadius.circular(10)
  //
  //                         ),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             MainController.to.image.value==""? Text("No Image Selected",style: TextStyle(color: Theme.of(context).hintColor),):Text(basename(MainController.to.image.value),style: TextStyle(color: Theme.of(context).hintColor)),
  //                             const Icon(Icons.attach_file,color: AppConst.accentColor,)
  //                           ],
  //                         ),),
  //                     )),
  //                     const SizedBox(height: 40,),
  //                     CustomButton(
  //                       onPressed: () {
  //                         _saveResource(_formKey.currentState);
  //                       },
  //                       title: "Save Resource",
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   },);
  // }


  void _showEditDialog( ParseObject? res) {
    if(res!=null){
      MainController.to.image.value=(res.get("image") as ParseFile).file?.path??"";
      MainController.to.selectedResource.value = res;
    }else{
      MainController.to.image.value="";
      MainController.to.selectedResource.value = null;
    }

    SmartDialog.show(builder: (context) {
      return SafeArea(
        child: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(

                  color: const Color.fromRGBO(22, 29, 64, 1),
                  child: Obx(() {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(left: 20,right:0,top: 5,bottom: 5),
                      tileColor: const Color.fromRGBO(22, 29, 64, 1),
                      trailing: IconButton(onPressed: (){
                        SmartDialog.dismiss();
                      }, icon: const Icon(Icons.close,color: Colors.white,)),
                      title:MainController.to.selectedResource.value==null?const Text("Add Resource", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)):const Text("Edit Resource", style: TextStyle(color: Colors.white)),
                      subtitle: const Text("Enter Details below", style: TextStyle(color: Colors.white),),
                    );
                  }
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30,),
                          FormBuilderTextField(
                              name: 'title',
                              initialValue: res==null?"":res.get("title"),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText:
                                'Title',
                              ),
                             // onChanged: _onChanged,
                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          const SizedBox(height: 20,),
                          FormBuilderTextField(
                              name: 'content',
                              minLines: 4,
                              maxLines: 8,
                              initialValue: res==null?"":res.get("content"),
                              decoration:  InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText:
                                'Content',
                              ),
                              //onChanged: _onChanged,
                              // valueTransformer: (text) => num.tryParse(text),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              keyboardType: TextInputType.text,
                            ),
                          const SizedBox(height: 20,),
                          FormBuilderTextField(
                            name: 'link',
                            initialValue: res==null?"":res.get("link"),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              labelText:
                              'link',
                            ),
                            // onChanged: _onChanged,
                            // valueTransformer: (text) => num.tryParse(text),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20,),
                          Obx(() => InkWell(
                            onTap: () async {
                              final ImagePicker _picker = ImagePicker();
                              var file  = await _picker.pickImage(source: ImageSource.gallery);
                              if(file!=null){
                                MainController.to.image.value=file.path;
                                //print(MainController.to.image.value?.path);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black38),
                                  borderRadius: BorderRadius.circular(10)

                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MainController.to.image.value==""? Text("No Image Selected",style: TextStyle(color: Theme.of(context).hintColor),):Text(basename(MainController.to.image.value),style: TextStyle(color: Theme.of(context).hintColor)),
                                  const Icon(Icons.attach_file,color: AppConst.accentColor,)
                                ],
                              ),),
                          )),
                          const SizedBox(height: 40,),
                          CustomButton(
                            onPressed: () {
                              _saveResource(_formKey.currentState);
                            },
                            title: "Save Resource",
                          ),
                        ],
                      ),
                    ),
                ),
              ],
            ),
          ),
        ),
      );
    },);
  }
}

 _saveResource(FormBuilderState? currentState) async {
  //AppUtils.showLoading();
   if(currentState!=null){
     currentState.save();
     print(currentState.value);
   }
  if(currentState==null || !currentState.isValid){
    AppUtils.showModalMessage(message:"Entered data is invalid or fields are empty!",color: AppConst.error);
    return;
  }

  if(MainController.to.image.value=="" && MainController.to.selectedResource.value==null){
    AppUtils.showModalMessage(message:"No Image Selected!",color: AppConst.error);
    return;
  }

  var content = currentState.value["content"];
  var title = currentState.value["title"];
  var link = currentState.value["link"];
  var fileUrl = "";
  if(File(MainController.to.image.value).existsSync()){
    fileUrl = MainController.to.image.value;
  }
  await MainController.to.saveResourcesData(file: fileUrl,content: content,title: title,link:link);

  SmartDialog.dismiss();

   await MainController.to.fetchResourcesData();
}
