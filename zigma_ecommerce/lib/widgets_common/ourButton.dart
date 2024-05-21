import 'package:flutter/material.dart';
import 'package:zigma_ecommerce/constants/consts.dart';

Widget ourButtonWidget({onPress, color, Color? textColor, String?title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: color,
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
