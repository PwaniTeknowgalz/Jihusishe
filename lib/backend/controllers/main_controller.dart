import 'dart:io';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:jihusishe/utils/app_utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth_controller.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();
  var showPlayer = false.obs;
  var audioPath = "".obs;

  var image = "".obs;

  var resources = {}.obs;
  var selectedResource = Rxn<ParseObject>();

  //Sample Query fetching generic data
  fetchSimpleData({model}) async {
    ParseObject reqObj = ParseObject(model);
    QueryBuilder<ParseObject> query;
    query = QueryBuilder<ParseObject>(reqObj);
    var data = await query.find();
    if (data.isNotEmpty) {
      return data;
    }

    return null;
  }

  //Sample Query using userid
  fetchSimpleDataUsingUser({model, userId}) async {
    ParseObject reqObj = ParseObject(model);
    QueryBuilder<ParseObject> query;

    if (userId) {
      query = QueryBuilder<ParseObject>(reqObj)
        ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
    } else {
      query = QueryBuilder<ParseObject>(reqObj);
    }

    var data = await query.find();
    if (data.isNotEmpty) {
      data;
    }
  }

  void openUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  //fetching resources data
  fetchResourcesData() async {
    AppUtils.showLoading();
    try {
      ParseObject reqObj = ParseObject("Resources");
      QueryBuilder<ParseObject> query;
      query = QueryBuilder<ParseObject>(reqObj);
      //   ..whereEqualTo('user', AuthController.to.parseUser.value?.objectId);
      var data = await query.find();
      resources.clear();
      if (data.isNotEmpty) {
        //print("Not Empty");
        var resCurrent = resources.value;
        for (var res in data) {
          var mres = res as ParseObject;

          resCurrent[mres.objectId] = mres;
        }
        resources.value = resCurrent;
        resources.refresh();
      }
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      print(e.message);
      AppUtils.showError("Resource Fetching Failed!");
    }
    SmartDialog.dismiss();
  }

  //save resources data
  saveResourcesData({required String file, title, content, link}) async {
    var ext = extension(file);
    // var mfile = file.renameSync(
    //     (await getApplicationDocumentsDirectory()).path + "res_image$ext");

    var parseFile = ParseFile(File(file), debug: true, name: "res_image$ext");
    var resource = ParseObject("Resources")
      ..set("title", title)
      ..set("content", content)
      ..set("link", link)
      ..set("author", AuthController.to.parseUser.value)
      ..set("image", parseFile);

    if (selectedResource.value != null) {
      resource = ParseObject("Resources")
        ..objectId = selectedResource.value?.objectId
        ..set("title", title)
        ..set("content", content)
        ..set("link", link)
        ..set("author",  AuthController.to.parseUser.value);

      if (file != "") {
        resource.set("image", parseFile);
      }
    }
    AppUtils.showLoading();
    try {
      ParseResponse? response = await resource.save();

      if (response.success) {
        var data = response.result;
        var allRes = resources.value;
        allRes[data.objectId] = data;

        resources.value = allRes;

        AppUtils.showSuccess("Resource Saved Successfully!");
        SmartDialog.dismiss();
        return true;
      } else {
        print(response.error?.message);
        AppUtils.showError("Resource Saving Failed!");
      }
      SmartDialog.dismiss();
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Resource Saving Failed!");
    }

    return false;
  }

  addComment({content}) async {
    initializeDateFormatting();

    var comment = {
      "content": content,
      "createdAt":DateFormat.yMd().add_Hm().format(DateTime.now()),
      "author": {
        "name": AuthController.to.parseUser.value?.get("name"),
        "email": AuthController.to.parseUser.value?.emailAddress,
        "objectId": AuthController.to.parseUser.value?.objectId
      }
    };

    //selectedResource.value?.setAdd("comments", comment);

    AppUtils.showLoading();
    try {
      var resource = ParseObject("Resources")
        ..objectId = selectedResource.value?.objectId ?? ""
        ..setAdd("comments", comment);
      ParseResponse? response = await resource.save();

      if (response.success) {
        var apiResponse = await ParseObject('Resources')
            .getObject(selectedResource.value?.objectId ?? "");
        // var queryBuilder  = QueryBuilder<ParseObject>(ParseObject("Resources"))
        //   ..whereEqualTo('objectId', selectedResource.value?.objectId ?? "");
        //
        // var apiResponse = await queryBuilder.query();
        if (apiResponse.success && apiResponse.result != null) {
          selectedResource.value = apiResponse.results?.first;
          selectedResource.refresh();
          var allRes = resources.value;
          allRes[selectedResource.value?.objectId] = selectedResource.value;
          resources.value = allRes;
          resources.refresh();
        }
        AppUtils.showSuccess("Comment Saved Successfully!");
      } else {
        print(response.error?.message);
        AppUtils.showError("Comment Saving Failed!");
      }
      SmartDialog.dismiss();
      return true;
    } on ParseError catch (e) {
      // e.g, e.code == 'canceled'
      AppUtils.showError("Comment Saving Failed!");
    }
    SmartDialog.dismiss();
    return false;
  }
}
