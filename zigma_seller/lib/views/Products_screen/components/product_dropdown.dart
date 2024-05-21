import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/products_controller.dart';

Widget productDrodown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButton(
                hint: normalText(text: "$hint", color: fontGrey),
                value: dropvalue.value == '' ? null : dropvalue.value,
                isExpanded: true,
                items: list.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: e.toString().text.make(),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (hint == "Category") {
                    controller.subCategoryvalue.value = '';
                    controller.populateSubCategory(newValue.toString());
                  }
                  dropvalue.value = newValue.toString();
                }))
        .box
        .white
        .padding(const EdgeInsets.symmetric(vertical: 4, horizontal: 4))
        .roundedSM
        .make(),
  );
}
