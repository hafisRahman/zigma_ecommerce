import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/constants/lists.dart';
import 'package:zigma_ecommerce/controllers/cart_controller.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: controller.placingOrder.value
            ? Center(child: loadingWidget())
            : ourButtonWidget(
                title: "Place my order",
                color: redColor,
                textColor: whiteColor,
                onPress: () async {
                  await controller.placeMyOrders(
                      orderPaymentMethod:
                          paymentMethods[controller.paymentIndex.value],
                      totalAmount: controller.totalP.value);
                  await controller.clearCart();

                  VxToast.show(context, msg: "Order Placed Successfully");
                }),
        appBar: AppBar(
          title: "Chose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodIcons.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(
                      //     color: whiteColor, width: 3, style: BorderStyle.solid),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        paymentMethodIcons[index],
                        width: double.infinity,
                        height: 120,
                        color: controller.paymentIndex.value == index
                            ? Colors.transparent
                            : Colors.black.withOpacity(0.4),
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.color
                            : BlendMode.darken,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                  activeColor: green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                          bottom: 1,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .fontFamily(semibold)
                              .color(textfieldGrey)
                              .make())
                    ]),
                  ).box.shadow.make(),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
