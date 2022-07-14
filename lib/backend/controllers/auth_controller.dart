import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../../frontend/auth/login.dart';
import '../../utils/app_utils.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  Rxn<ParseUser> parseUser = Rxn<ParseUser>();
  Rxn<ParseObject> requestCount = Rxn<ParseObject>();

  @override
  Future<void> onInit() async {
    //run every time auth state changes
    // ever(firebaseUser, handleAuthChanged);
    
    await getParseUser();
    ever(parseUser, handleUserChanged);
    super.onInit();
  }

  // Firebase user one-time fetch
  Future<ParseUser> get getUser async {
    return await ParseUser.currentUser();
  }

  //get the firestore user from the firestore collection
  Future<void> getParseUser() async {
    try {
      if ((await ParseUser.currentUser()) != null) {
        parseUser.value = await ParseUser.currentUser();
        parseUser.refresh();
      }

      //print(parseUser.value);
      update();
    } catch (e) {
      print(e);
    }
  }

  //Login user Code
  login(username, password) async {

    if(username==""){
      AppUtils.showError("The username field must be filled!");
      return false;
    }

    if(password==""){
      AppUtils.showError("The password field must be filled!");
      return false;
    }

    try {
      var user = ParseUser(username, password, username);
      var res = await user.login();

      if (res.success) {
        await getParseUser();

        AppUtils.showSuccess('Login Successful!');
        return true;
      } else {
        AppUtils.showError(res.error?.message);
        return false;
      }
    } catch (error) {
      print(error);
      AppUtils.showError('Login Attempt Failed!');
    }

    return false;
  }

  //Signup User Code
  signup(name, email, phone, town, password) async {
    var user = ParseUser(email, password, email)
      ..set("name", name)
      ..set("phone", phone)
      ..set("town", town)
      ..set("hasAccount", true)
      ..set("photoUrl", "")
      ..set("role", "user")
      ..set("accountStatus", 1);

    try {
      var res = await user.signUp();

      if (res.success) {
        await getParseUser();

        AppUtils.showSuccess('Account Created Successfully!');
        return true;
      } else {
        AppUtils.showError(res.error?.message);
        return false;
      }
    } catch (error) {
      AppUtils.showError(error.toString());
    }

    AppUtils.showError('Signup Attempt Failed!');
    return false;
  }

  //Update Profile
  updateProfile(name, phone, town) async {
    //create the new user object
    ParseUser user = await ParseUser.currentUser();
    //create the user in firestore
    user
      ..set("name", name)
      ..set("phone", phone)
      ..set("town", town)
      ..set("hasAccount", true);

    await user.save();
    //await getParseUser();
    AppUtils.showSuccess('Profile Update Successful!');
    return true;
  }

  //password reset email
  Future<bool> sendPasswordResetEmail(email) async {
    AppUtils.showLoading();
    try {
      final ParseUser user = ParseUser(null, null, email);
      final ParseResponse parseResponse = await user.requestPasswordReset();
      if (parseResponse.success) {
        AppUtils.showSuccess('Password Reset Link sent to your email!');
        SmartDialog.dismiss();
        return true;
      } else {
        AppUtils.showError(parseResponse.error?.message);
      }
    } catch (error) {
      AppUtils.showError(error.toString());
    }
    SmartDialog.dismiss();
    return false;
  }

  // Sign out
  Future<bool> signOut() async {
    AppUtils.showLoading();
    if (await ParseUser.currentUser() != null) {
      await (await ParseUser.currentUser()).logout();
      await getParseUser();
      parseUser.value = null;
      update();
    } else {
      parseUser.value = null;
      update();
    }

    //Get.offAll(() => const Login());
    SmartDialog.dismiss();
    return true;
  }

  handleUserChanged(ParseUser? user) async {
    //print(_user);
    if (user == null) {
      if (Get.currentRoute != "/" && Get.currentRoute != "/Login") {
        Get.offAll(() => const Login());
      }
    }
  }
}
