import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/controllers/cart_controller.dart';
import 'package:zigma_ecommerce/services/firestore_services.dart';
import 'package:zigma_ecommerce/views/Cart_Screan/shipping_screan.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
            child: ourButtonWidget(
                title: "Proceed to shipping",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  Get.to(() => const ShippingDetails());
                })),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStroreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingWidget(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty ".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  width: 100,
                                ),
                                title:
                                    "${data[index]['title']} (x${data[index]['qty']})"
                                        .text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .make(),
                                subtitle: "${data[index]['tPrice']}"
                                    .numCurrency
                                    .text
                                    .size(14)
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FireStroreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .roundedSM
                          .width(context.screenWidth - 60)
                          .padding(const EdgeInsets.all(12))
                          .color(Colors.yellow)
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //     width: context.screenWidth - 60,
                      //     child: ourButtonWidget(
                      //         title: "Proceed to shipping",
                      //         color: redColor,
                      //         textColor: whiteColor,
                      //         onPress: () {}))
                    ],
                  ),
                );
              }
            }));
  }
}
