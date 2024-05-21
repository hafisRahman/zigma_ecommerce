import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data["p_imgs"].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                  // imgProduct,
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
          10.heightBox,
          // Title and Details Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(
                    text: "${data['p_name']}", color: fontGrey, size: 16.0),
                10.heightBox,
                Row(children: [
                  boldText(
                      text: "${data['p_category']}",
                      color: fontGrey,
                      size: 16.0),
                  10.widthBox,
                  normalText(
                      text: "${data['p_subcategory']}",
                      color: fontGrey,
                      size: 16.0)
                ]),
                10.heightBox,

                // rating
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  count: 5,
                  maxRating: 5,
                  size: 25,
                ),
                10.heightBox,
                // Price amount
                boldText(
                    text: "\$${data['p_price']}",
          
                    color: purpleColor,
                    size: 18.0),

                // COlour Section
                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: boldText(text: "Color :", color: purpleColor),
                        ),
                        Row(
                            children: List.generate(
                          data['p_colors'].length,
                          (index) => VxBox()
                              .size(40, 40)
                              .roundedFull
                              .color(Color(data['p_colors'][index]))
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .make()
                              .onTap(() {}),
                        ))
                      ],
                    ),

                    //Quantity Row

                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: boldText(text: "Quantity :", color: fontGrey),
                        ),
                        normalText(
                            text: "${data['p_quantity']} items",
                            color: fontGrey)
                      ],
                    )
                  ],
                ).box.white.padding(const EdgeInsets.all(8)).make(),

                // DESCRIPTION SECTION
                const Divider(),
                15.heightBox,
                boldText(
                  text: "Description",
                  color: fontGrey,
                ),

                10.heightBox,
                normalText(
                    text: "${data['p_description']} ", color: darkFontGrey),

                // Button Section
                10.heightBox,
              ],
            ),
          ),

          10.heightBox,
        ],
      )),
    );
  }
}
