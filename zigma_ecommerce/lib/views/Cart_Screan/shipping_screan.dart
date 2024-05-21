import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/controllers/cart_controller.dart';
import 'package:zigma_ecommerce/views/Cart_Screan/payment_method.dart';
import 'package:zigma_ecommerce/widgets_common/custom_textfeild.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    var addrs = controller.addressController.text;
    var city = controller.cityController.text;
    var state = controller.stateController.text;
    var pCode = controller.postalController.text;
    var contact = controller.contactController.text;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: ourButtonWidget(
          title: "Continue to shipping",
          color: redColor,
          textColor: whiteColor,
          onPress: () {
            if (addrs.length > 10 ||
                city.length > 2 ||
                state.length > 3 ||
                pCode.length >= 6 ||
                contact.length > 9) {
              Get.to(() => const PaymentMethod());
            } else {
              VxToast.show(context, msg: "Please fill the details correctly");
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customeTextfeild(
                title: "Address",
                hint: "Address",
                securePass: false,
                controller: controller.addressController),
            customeTextfeild(
                title: "City",
                hint: "City",
                securePass: false,
                controller: controller.cityController),
            customeTextfeild(
                title: "State",
                hint: "State",
                securePass: false,
                controller: controller.stateController),
            customeTextfeild(
                title: "Postal Code",
                hint: "Postal Code",
                securePass: false,
                controller: controller.postalController),
            customeTextfeild(
                title: "Contact",
                hint: "Contact",
                securePass: false,
                controller: controller.contactController),
          ],
        ),
      ),
    );
  }
}
