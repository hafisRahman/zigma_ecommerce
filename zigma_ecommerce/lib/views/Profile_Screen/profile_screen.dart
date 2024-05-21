import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/constants/lists.dart';
import 'package:zigma_ecommerce/controllers/auth_controller.dart';
import 'package:zigma_ecommerce/services/firestore_services.dart';
import 'package:zigma_ecommerce/views/Cart_Screan/cart_screen.dart';
import 'package:zigma_ecommerce/views/Profile_Screen/components/details_card.dart';
import 'package:zigma_ecommerce/views/Profile_Screen/edit_profile_screen.dart';
import 'package:zigma_ecommerce/views/Profile_Screen/profile_controller.dart';
import 'package:zigma_ecommerce/views/auth_Screan/login_screan.dart';
import 'package:zigma_ecommerce/views/chat_screan/messaging_screan.dart';
import 'package:zigma_ecommerce/views/orders_screan/orders_screan.dart';
import 'package:zigma_ecommerce/views/wishlist_screen/wishlist_screen.dart';
import 'package:zigma_ecommerce/widgets_common/bg.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FireStroreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor)),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];

                    return SafeArea(
                        child: Column(
                      children: [
                        // Edit Profile Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child:
                                  //edit Button
                                  const Icon(Icons.edit, color: whiteColor)
                                      .onTap(() {
                                controller.nameController.text = data['name'];

                                Get.to(() => EditProfileScrean(
                                      data: data,
                                    ));
                              })),
                        ),

                        // Users Details Section

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image.asset(imgProfile2,
                                          width: 100, fit: BoxFit.cover)
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  : Image.network(data['imageUrl'],
                                          width: 100, fit: BoxFit.cover)
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .capitalize
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['email']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make()
                                ],
                              )),
                              // LogOut Button
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                    color: whiteColor,
                                  )),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signOutMethod(context);
                                    Get.offAll(() => const LogInScrean());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .white
                                      .make()),
                            ],
                          ),
                        ),
                        20.heightBox,
                        FutureBuilder(
                            future: FireStroreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingWidget(),
                                );
                              } else {
                                var countdata = snapshot.data;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(
                                            count: countdata[0].toString(),
                                            title: "In Your Cart ",
                                            width: context.screenWidth / 3.4)
                                        .onTap(() {
                                      Get.to(() => const CartScreen());
                                    }),
                                    detailsCard(
                                            count: countdata[1].toString(),
                                            title: "Your Orders ",
                                            width: context.screenWidth / 3.4)
                                        .onTap(() {
                                      Get.to(() => const OrdersScrean());
                                    }),
                                    detailsCard(
                                            count: countdata[2].toString(),
                                            title: "Your Wish List ",
                                            width: context.screenWidth / 3.4)
                                        .onTap(() {
                                      Get.to(() => const WishlistScreen());
                                    }),
                                  ],
                                );
                              }
                            }),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     detailsCard(
                        //             count: data['cart_count'],
                        //             title: "In Your Cart ",
                        //             width: context.screenWidth / 3.4)
                        //         .onTap(() {
                        //       Get.to(() => const CartScreen());
                        //     }),
                        //     detailsCard(
                        //             count: data['order_count'],
                        //             title: "Your Orders ",
                        //             width: context.screenWidth / 3.4)
                        //         .onTap(() {
                        //       Get.to(() => const OrdersScrean());
                        //     }),
                        //     detailsCard(
                        //             count: data['wishlist_count'],
                        //             title: "Your Wish List ",
                        //             width: context.screenWidth / 3.4)
                        //         .onTap(() {
                        //       Get.to(() => const WishlistScreen());
                        //     }),
                        //   ],
                        // ),

                        // Button Section

                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: ((context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          }),
                          itemCount: ProfileButtonList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const OrdersScrean());
                                      break;
                                    case 1:
                                      Get.to(() => const WishlistScreen());
                                      break;
                                    case 2:
                                      Get.to(() => const MessagesScreen());
                                      break;
                                  }
                                },
                                leading: Image.asset(
                                  profileButtonsIcon[index],
                                  width: 22,
                                ),
                                title: ProfileButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make());
                          },
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .white
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make()
                      ],
                    ));
                  }
                })));
  }
}
