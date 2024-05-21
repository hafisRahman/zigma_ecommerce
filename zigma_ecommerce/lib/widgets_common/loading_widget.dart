import 'package:flutter/material.dart';
import 'package:zigma_ecommerce/constants/colors.dart';

Widget loadingWidget({Widget? child}) {
  return const CircularProgressIndicator(
   valueColor: AlwaysStoppedAnimation(redColor),
  );
}
