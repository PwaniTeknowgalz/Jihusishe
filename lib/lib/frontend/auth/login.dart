// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../backend/controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 65),
        width: Get.size.width,
        height: Get.size.height,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: Get.size.height * .03),
                SizedBox(height: 25),
                Text("Welcome Back!",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black87)),
                SizedBox(height: 25),
                //Email field
                CustomTextField(
                    title: "Email",
                    iconData: Icons.email_sharp,
                    name: "email",
                    textInputType: TextInputType.emailAddress),
                SizedBox(height: 12),
                //Password field
                CustomTextField(
                    title: "Password",
                    iconData: Icons.lock_sharp,
                    name: "password",
                    obscure: true,
                    textInputType: TextInputType.text),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          // Get.dialog(RequestPassword());
                        },
                        child: Text("Forgot Password?",
                            style: TextStyle(color: AppConst.secColor))),
                  ],
                ),
                SizedBox(height: 25),
                CustomButton(
                  onPressed: _loginUser,
                  title: "Login",
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Get.to(() => Signup());
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Don\'t have an account?'),
                          TextSpan(
                              text: ' Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConst.mainColor,
                              )),
                        ],
                      ),
                    )),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    FocusScope.of(context).unfocus();
    var validate = _formKey.currentState!.validate();
    if (validate) {
      _formKey.currentState!.save();
      var fields = _formKey.currentState!.value;
      AppUtils.showLoading();
      var loggedIn =
          await AuthController.to.login(fields["email"], fields["password"]);
      SmartDialog.dismiss();
    }
  }
}
