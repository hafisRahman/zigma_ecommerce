import 'package:zigma_seller/constants/const.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .size(16.0)
      .makeCentered()
      .box
      .color(whiteColor)
      .size(100, 100)
      .roundedSM
      .make();
}
