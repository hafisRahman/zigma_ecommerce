import 'package:flutter/material.dart';
import 'package:zigma_seller/constants/colors.dart';

Widget loadingIndicator({circleColor= purpleColor}) {
  return  Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(circleColor),
    ),
  );
}
