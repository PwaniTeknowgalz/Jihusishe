// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import '../../backend/controllers/auth_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';
import '../screens/dashboard.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                Row(
                  children: [
                    Text("Create an Account ",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 30),

                //Name field
                CustomTextField(
                    title: "Name",
                    iconData: Icons.person,
                    name: "name",
                    textInputType: TextInputType.text),
                SizedBox(height: 12),
                //Email field
                CustomTextField(
                    title: "Email",
                    iconData: Icons.email_sharp,
                    name: "email",
                    textInputType: TextInputType.emailAddress),
                SizedBox(height: 12),

                //Phone field
                CustomTextField(
                    title: "Phone",
                    iconData: Icons.phone,
                    name: "phone",
                    textInputType: TextInputType.phone),
                SizedBox(height: 12),

                //Location field
                CustomTextField(
                    title: "Town",
                    iconData: Icons.account_balance_sharp,
                    name: "town",
                    textInputType: TextInputType.text),
                SizedBox(height: 12),
                //Password field
                CustomTextField(
                    title: "Password",
                    iconData: Icons.lock_sharp,
                    name: "password",
                    obscure: true,
                    textInputType: TextInputType.text),

                SizedBox(height: 25),
                CustomButton(
                  onPressed: () {
                    _signupUser();
                  },
                  title: "Register",
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Get.to(()=>Login());
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Already have an account?'),
                          TextSpan(
                              text: ' Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppConst.mainColor,
                              )),
                        ],
                      ),
                    )),
                SizedBox(height: 25),
                Divider()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signupUser() async {
    FocusScope.of(context).unfocus();
    var validate = _formKey.currentState!.validate();
    if (validate) {
      _formKey.currentState!.save();
      var fields = _formKey.currentState!.value;
      // print(fields.toString());
      AppUtils.showLoading();
      var loggedIn = await AuthController.to.signup(fields["name"],
          fields["email"], fields["phone"], fields["town"], fields["password"]);
      SmartDialog.dismiss();

      if(loggedIn){
        Get.offUntil(GetPageRoute(page: () => const DashBoard()), (route) => false);
        Get.to(()=>DashBoard());
      }
    }
  }
}
