import 'package:get/get.dart';

import 'controllers/auth_controller.dart';
import 'controllers/main_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<MainController>(MainController());

  }
}
