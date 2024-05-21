import 'package:flutter/material.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/views/orders_screan/components/order_place_details.dart';
import 'package:zigma_ecommerce/views/orders_screan/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;

  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics:const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              orderStatus(
                  title: "Placed",
                  color: redColor,
                  icon: Icons.done,
                  showDone: data['order_placed']),
              orderStatus(
                  title: "Confirmed",
                  color: Vx.blue900,
                  icon: Icons.thumb_up,
                  showDone: data['order_confirmed']),
              orderStatus(
                  title: "On Delivery",
                  color: Colors.orange.shade600,
                  icon: Icons.fire_truck_outlined,
                  showDone: data['order_on_delivery']),
              orderStatus(
                  title: "Delivered",
                  color: green,
                  icon: Icons.done_all_rounded,
                  showDone: data['order_deliverd']),
              Divider(),
              10.heightBox,

              // order place details are in this column
              Column(
                children: [
                  orderPlaceDetails(
                    title1: "Shipping Method",
                    d1: data['shipping_method'],
                    title2: "Order Code",
                    d2: data['order_code'],
                  ),
                  orderPlaceDetails(
                    title1: "Order Date",
                    d1: intl.DateFormat().add_yMd().format(
                          (data['order_date'].toDate()),
                        ),
                    title2: "Payment Method",
                    d2: data['payment_method'],
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data['order_by_name']}".text.make(),
                            "${data['order_by_email']}".text.make(),
                            "${data['order_by_address']}".text.make(),
                            "${data['order_by_city']}".text.make(),
                            "${data['order_by_state']}".text.make(),
                            "${data['order_by_contact']}".text.make(),
                            "${data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.white.roundedSM.make(),

              Divider(),
              10.heightBox,

              "Ordered Products".text.size(16).makeCentered(),
              ListView(
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                          title1: data['orders'][index]['title'],
                          d1: "${data['orders'][index]['qty']}x",
                          title2: data['orders'][index]['tPrice'],
                          d2: "Refundable"),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Color(data['orders'][index]['color']),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .roundedSM
                  .margin(EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,

              
            ],
          ),
        ), //mark
      ),
    );
  }
}
