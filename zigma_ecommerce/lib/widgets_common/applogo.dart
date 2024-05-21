import 'package:flutter/material.dart';
import 'package:zigma_ecommerce/constants/consts.dart';

Widget appLogoWidget() {
  return Image.asset(icAppLogo)
      .box
      .white
      .size(77, 77)
      .padding(const EdgeInsets.all(8))
      .roundedFull
      .make();
}
