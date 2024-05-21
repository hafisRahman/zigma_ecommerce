import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:zigma_seller/controllers/products_controller.dart';
import 'package:zigma_seller/services/store_services.dart';
import 'package:zigma_seller/views/Products_screen/add_product.dart';
import 'package:zigma_seller/views/Products_screen/product_details.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => const AddProductScreen());
          },
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        appBar: appBarWidget(products),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return normalText(text: "No products yet ", color: purpleColor);
              } else {
                var data = snapshot.data!.docs;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                        data.length,
                        (index) => Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => ProductDetails(data: data[index]));
                            },
                            leading: Image.network(
                              // imgProduct,
                              data[index]['p_imgs'][0],
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                            title: boldText(
                                text: "${data[index]['p_name']}",
                                color: darkFontGrey,
                                size: 14.0),
                            subtitle: Row(
                              children: [
                                normalText(
                                    text: "\$${data[index]['p_price']}",
                                    color: fontGrey),
                                10.widthBox,
                                boldText(
                                    text: data[index]['is_featured'] == true
                                        ? "Featured"
                                        : "",
                                    color: green),
                              ],
                            ),
                            trailing: VxPopupMenu(
                                menuBuilder: () => Column(
                                      children: List.generate(
                                        popupMenuTitles.length,
                                        (i) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                popupMenuIcons[i],
                                                color:
                                                    data[index]['featured_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? green
                                                        : darkFontGrey,
                                              ),
                                              5.widthBox,
                                              normalText(
                                                  text:
                                                      data[index]['featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? "Remove featured"
                                                          : popupMenuTitles[i],
                                                  color: darkFontGrey)
                                            ],
                                          ).onTap(() {
                                            switch (i) {
                                              case 0:
                                                if (data[index]
                                                        ['is_featured'] ==
                                                    true) {
                                                  controller.removeFeatured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Removed");
                                                } else {
                                                  controller.addFeatured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Added");
                                                }

                                                break;
                                              case 1:
                                                break;
                                              case 2:
                                                controller.removeProduct(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Product Removed");
                                                break;
                                              default:
                                            }
                                          }),
                                        ),
                                      ),
                                    ).box.white.rounded.width(200).make(),
                                clickType: VxClickType.singleClick,
                                child: const Icon(Icons.more_vert_rounded)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
