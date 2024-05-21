import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:zigma_seller/controllers/orders_controller.dart';
import 'package:zigma_seller/services/store_services.dart';
import 'package:zigma_seller/views/Orders_screen/order_details.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());

    return Scaffold(
        appBar: appBarWidget(orders),
        body: StreamBuilder(
            stream: StoreServices.getOrders(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return normalText(text: "No orders yet ", color: purpleColor);
              } else {
                var data = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var time = data[index]['order_date'].toDate();

                        return ListTile(
                          onTap: () {
                            Get.to(() => OrderDetails(
                                  data: data[index],
                                ));
                          },
                          tileColor: textfieldGrey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: boldText(
                              text: "${data[index]['order_code']}",
                              color: purpleColor,
                              size: 14.0),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  boldText(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(time),
                                      color: fontGrey),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.payment,
                                    color: fontGrey,
                                  ),
                                  10.widthBox,
                                  boldText(text: "Unpaid", color: redColor),
                                ],
                              ),
                            ],
                          ),
                          trailing: boldText(
                              text: "\$ ${data[index]['total_amount']}",
                              color: purpleColor,
                              size: 16.0),
                        ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                      }),
                    ),
                  ),
                );
              }
            }));
  }
}
