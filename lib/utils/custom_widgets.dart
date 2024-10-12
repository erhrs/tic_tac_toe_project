import 'package:flutter/material.dart';

customTextStyle({Color? color, double? fontSize}) {
  return TextStyle(
      color: color,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      height: 2);
}

Widget customButton(
    {required String title, required void Function()? onPressed,required bool lightBool}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      foregroundColor: lightBool?Colors.blue:Colors.white,
      backgroundColor: lightBool?Colors.white:Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    onPressed: onPressed,
    child: Text( title, style: customTextStyle(fontSize: 20)),
  );
}
