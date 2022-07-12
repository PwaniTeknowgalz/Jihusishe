import 'package:flutter/material.dart';

import '../../utils/app_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: onPressed,
        style: AppConst.buttonStyle,
        child: Text(title),
      ),
    );
  }
}