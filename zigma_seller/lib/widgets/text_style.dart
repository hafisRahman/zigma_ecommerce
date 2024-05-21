import 'package:zigma_seller/constants/const.dart';

Widget normalText({text, color = whiteColor, size = 14.0}) {
  return "$text".text.color(color).size(size).make();
}

Widget boldText({text, color = whiteColor, size = 14.0}) {
  return "$text".text.semiBold.color(color).size(size).make();
}
