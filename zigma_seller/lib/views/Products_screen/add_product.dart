import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/products_controller.dart';
import 'package:zigma_seller/views/Products_screen/components/product_Images.dart';
import 'package:zigma_seller/views/Products_screen/components/product_dropdown.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: "Add product", size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: whiteColor)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(
                      text: "save",
                    ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextFeild(
                    hint: "eg. BMW",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextFeild(
                    hint: "eg. Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextFeild(
                    hint: "eg. \$100",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextFeild(
                    hint: "eg. 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                // category dropDown
                productDrodown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                // subCategory dropDown
                productDrodown("Sub Category", controller.subCategoryList,
                    controller.subCategoryvalue, controller),
                10.heightBox,
                const Divider(color: lightGrey),
                normalText(text: "Choose product images"),
                5.heightBox,

                // product Images
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImageList[index] != null
                          ? Image.file(
                              controller.pImageList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),

                10.heightBox,
                const Divider(color: lightGrey),

                boldText(text: "Choose product colours"),
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: List.generate(
                      8,
                      (index) => Stack(
                        alignment: Alignment.center,
                        children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(80, 65)
                              .make()
                              .onTap(() {
                            controller.selectedColorIndex.value = index;
                          }),
                          controller.selectedColorIndex.value == index
                              ? const Icon(Icons.done, color: whiteColor)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
