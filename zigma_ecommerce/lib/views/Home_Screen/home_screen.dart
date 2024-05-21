import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/constants/lists.dart';
import 'package:zigma_ecommerce/controllers/home_controllers.dart';
import 'package:zigma_ecommerce/services/firestore_services.dart';
import 'package:zigma_ecommerce/views/Catogorie_screan/item_details.dart';
import 'package:zigma_ecommerce/views/Home_Screen/componenets/featured_Buttons.dart';
import 'package:zigma_ecommerce/views/Home_Screen/search_screan.dart';
import 'package:zigma_ecommerce/widgets_common/homeButtons.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';

class HomeScrean extends StatelessWidget {
  const HomeScrean({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,

              // search feild

              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    }
                  }),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //Swiper Brands
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: slidersList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            slidersList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,

                    //dealButtons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2,
                          (index) => homeButtons(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth / 2.5,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                              title: index == 0 ? todaysDeal : flashSale)),
                    ),

                    //  second Swipers
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: seconsSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            seconsSliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    10.heightBox,
                    //   catogery Buttons

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                                height: context.screenHeight * 0.15,
                                width: context.screenWidth / 3.5,
                                icon: index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                title: index == 0
                                    ? topCategeries
                                    : index == 1
                                        ? brand
                                        : topSeller,
                              )),
                    ),

                    //Featured categories
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredCatogeries.text
                            .color(darkFontGrey)
                            .size(18)
                            .fontFamily(semibold)
                            .make()),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButtons(
                                        icon: featuredImages1[index],
                                        title: featuredTitle1[index]),
                                    10.heightBox,
                                    featuredButtons(
                                        icon: featuredImages2[index],
                                        title: featuredTitle2[index]),
                                  ],
                                )),
                      ),
                    ),
                    //featured Products
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future:
                                    FireStroreServices.getfeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingWidget(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No featured Products"
                                        .text
                                        .white
                                        .make();
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                      featuredData[index]
                                                          ['p_imgs'][0],
                                                      width: 130,
                                                      height: 200,
                                                      fit: BoxFit.fitHeight),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_name']}"
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(darkFontGrey)
                                                      .make(),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_price']}"
                                                      .text
                                                      .color(redColor)
                                                      .fontFamily(bold)
                                                      .size(16)
                                                      .make(),
                                                ],
                                              )
                                                  .box
                                                  .white
                                                  .roundedSM
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(() => ItemDetails(
                                                      title:
                                                          "${featuredData[index]['p_name']}",
                                                      data: featuredData[index],
                                                    ));
                                              })),
                                    );
                                  }
                                }),
                          )
                        ],
                      ),
                    ),

                    // Third Swiper
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: seconsSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            seconsSliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),

                    // All Products
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "All Products"
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(18)
                          .make(),
                    ),

                    StreamBuilder(
                        stream: FireStroreServices.getAllProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingWidget(),
                            );
                          } else {
                            var allProductData = snapshot.data!.docs;

                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // getting product image
                                      Image.network(
                                          allProductData[index]['p_imgs'][0],
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover),
                                      const Spacer(),
                                      //geting product name
                                      "${allProductData[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      // get price
                                      "${allProductData[index]['p_price']}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(16)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .roundedSM
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allProductData[index]['p_name']}",
                                          data: allProductData[index],
                                        ));
                                  });
                                });
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
