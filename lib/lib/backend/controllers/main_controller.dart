import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'auth_controller.dart';

class MainController extends GetxController {


  static MainController get to => Get.find();


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
}
