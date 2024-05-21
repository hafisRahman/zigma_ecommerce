import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

Widget exitDialogue(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButtonWidget(
                title: "Yes",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                }),
            ourButtonWidget(
                title: "No",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                })
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).roundedSM.make(),
  );
}
