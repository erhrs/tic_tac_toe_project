import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

customTextStyle({Color? color, double? fontSize}) {
  return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: fontSize,);
}

Widget customButton(
    {required String title,
    required void Function()? onPressed,
    required bool lightBool}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: lightBool ? Colors.blue : Colors.white,
      backgroundColor: lightBool ? Colors.white : Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: onPressed,
    child: Text(title, style: customTextStyle(fontSize: 20)),
  );
}

void showWinningDialog() {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      child: Lottie.asset(
        'assets/animations/Animation - 1728715686260.json',
        width: 200,
        height: 200,
      ),
    ),
    barrierDismissible: false,
  );

  Timer(const Duration(seconds: 3), () {
    Get.back();
  });
}
