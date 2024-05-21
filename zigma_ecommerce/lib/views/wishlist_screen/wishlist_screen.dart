import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/services/firestore_services.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStroreServices.getWishlists(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingWidget(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No wishlist yet !"
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Image.network(
                          "${data[index]['p_imgs'][0]}",
                          width: 100,
                        ),
                        title: "${data[index]['p_name']}"
                            .text
                            .size(16)
                            .fontFamily(semibold)
                            .make(),
                        subtitle: "${data[index]['p_price']}"
                            .numCurrency
                            .text
                            .size(14)
                            .color(redColor)
                            .fontFamily(semibold)
                            .make(),
                        trailing: const Icon(
                          Icons.favorite,
                          color: redColor,
                        ).onTap(() async {
                          await firestore
                              .collection(productCollection)
                              .doc(data[index].id)
                              .set({
                            'p_wishlist':
                                FieldValue.arrayRemove([currentUser!.uid])
                          }, SetOptions(merge: true));

                          // FireStroreServices.deleteDocument(data[index].id);
                        }),
                      );
                    }),
              );
            }
          }),
    );
  }
}
