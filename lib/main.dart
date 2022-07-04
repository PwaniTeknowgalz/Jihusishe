import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:jihusishe/lib/frontend/screens/landing.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'lib/frontend/auth/login.dart';
import 'lib/backend/main_binding.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var keyParseApplicationId = "L1cjXTUiY3HMes9N4BPs5jpNwuBA3bqke9UW8bcI";
  var keyParseServerUrl = "https://parseapi.back4app";
  var keyParseClientKey = "QQmandtEKrIsXEOwP5MfqPHK9gepQKqvCzAe69Br";

  var store = await CoreStoreSembastImp.getInstance(password: "mobipeace");

  await Parse().initialize(keyParseApplicationId, keyParseServerUrl,
      clientKey: keyParseClientKey, autoSendSessionId: true, coreStore: store);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: MainBinding(),
      title: 'MobiPeace',
      theme: ThemeData(
        // textTheme: GoogleFonts.oxygenTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        primarySwatch: Colors.teal,
      ),
      //home: const SplashScreen(),
      home: const Welcome(),
      builder: (BuildContext context, Widget? child) {
        return FlutterSmartDialog(child: child);
      },
    );
  }
}
