import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/orders_controller.dart';
import 'package:zigma_seller/views/Orders_screen/components/order_placeDetails.dart';
import 'package:intl/intl.dart ' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_deliverd'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: boldText(text: "Order details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
                title: "Confirm order",
                color: green,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: "order_confirmed",
                      status: true,
                      docID: widget.data.id);
                }),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const Divider(),
                  10.heightBox,

                  //  Order delivery status section

                  Visibility(
                    visible: controller.confirmed.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText(
                            text: "Order status",
                            color: Colors.black,
                            size: 16.0),
                        SwitchListTile(
                          activeColor: green,
                          value: true,
                          onChanged: (value) {},
                          title: boldText(text: "Placed", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: controller.confirmed.value,
                          onChanged: (value) {
                            controller.confirmed.value = value;
                          },
                          title: boldText(text: "Confirmed", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: controller.ondelivery.value,
                          onChanged: (value) {
                            controller.ondelivery.value = value;
                            controller.confirmed(true);
                            controller.changeStatus(
                                title: "order_on_delivery",
                                status: value,
                                docID: widget.data.id);
                          },
                          title: boldText(text: "On delivery", color: fontGrey),
                        ),
                        SwitchListTile(
                          activeColor: green,
                          value: false,
                          onChanged: (value) {
                            controller.delivered.value = value;

                            controller.confirmed(true);
                            controller.changeStatus(
                                title: "order_deliverd",
                                status: value,
                                docID: widget.data.id);
                          },
                          title: boldText(text: "Delivered", color: fontGrey),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(8))
                        .outerShadowMd
                        .white
                        .border(color: lightGrey)
                        .roundedSM
                        .make(),
                  ),

                  // order details are in this section
                  Column(
                    children: [
                      orderPlaceDetails(
                          title1: "Shipping Method",
                          d1: "${widget.data['shipping_method']}",
                          title2: "Order Code",
                          d2: "${widget.data['order_code']}"),
                      orderPlaceDetails(
                        title1: "Order Date",
                        d1: intl.DateFormat().add_yMd().format(
                              (widget.data['order_date'].toDate()),
                            ),
                        title2: "Payment Method",
                        d2: "${widget.data['payment_method']}",
                      ),
                      orderPlaceDetails(
                          title1: "Payment Status",
                          d1: "Unpaid",
                          title2: "Delivery Status",
                          d2: "Order Placed"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //shipping Address Details
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Shipping Address  ",
                                    color: purpleColor),
                                "${widget.data['order_by_name']}".text.make(),
                                "${widget.data['order_by_email']}".text.make(),
                                "${widget.data['order_by_address']}"
                                    .text
                                    .make(),
                                "${widget.data['order_by_city']}".text.make(),
                                "${widget.data['order_by_state']}".text.make(),
                                "${widget.data['order_by_contact']}"
                                    .text
                                    .make(),
                                "${widget.data['order_by_postalcode']}"
                                    .text
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boldText(
                                      text: "Total amount", color: purpleColor),
                                  boldText(
                                      text: "\$ ${widget.data['total_amount']}",
                                      color: redColor),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),

                  const Divider(),
                  10.heightBox,

                  boldText(
                      text: "Ordered products", color: fontGrey, size: 16.0),
                  ListView(
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                              title1: "${controller.orders[index]['title']}",
                              d1: "${controller.orders[index]['qty']}x",
                              title2:
                                  "\$ ${controller.orders[index]['tPrice']}",
                              d2: "Refundable"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 20,
                              height: 20,
                              color: Color(controller.orders[index]['color']),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  )
                      .box
                      .outerShadowMd
                      .white
                      .roundedSM
                      .margin(const EdgeInsets.only(bottom: 4))
                      .make(),
                  20.heightBox,
                ],
              ),
            )),
      ),
    );
  }
}
