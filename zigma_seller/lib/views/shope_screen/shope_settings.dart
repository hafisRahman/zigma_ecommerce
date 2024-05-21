import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/profile_controller.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class ShopeSettings extends StatelessWidget {
  const ShopeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        backgroundColor: purpleColor,
        title: boldText(
          text: shopeSettings,
        ),
        actions: [
          controller.isloading.value
              ? loadingIndicator(circleColor: whiteColor)
              : TextButton(
                  onPressed: () async {
                    controller.isloading(true);
                    await controller.updateShope(
                      shopname: controller.shopeNameController.text,
                      shopAddress: controller.shopeAddressController.text,
                      shopmobile: controller.shopeMobileController.text,
                      shopwebsite: controller.shopeWebController.text,
                      shopdesc: controller.shopeDescriptnController.text,
                    );
                    VxToast.show(context, msg: "Shope Updated");
                  },
                  child: normalText(
                    text: save,
                  ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextFeild(
                label: shopeName,
                hint: nameHint,
                controller: controller.shopeNameController),
            10.heightBox,
            customTextFeild(
                label: address,
                hint: shopeAddressHint,
                controller: controller.shopeAddressController),
            10.heightBox,
            customTextFeild(
                label: mobile,
                hint: shopeMobileHint,
                controller: controller.shopeMobileController),
            10.heightBox,
            customTextFeild(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopeWebController),
            10.heightBox,
            customTextFeild(
                isDesc: true,
                label: description,
                hint: shopDescHint,
                controller: controller.shopeDescriptnController)
          ],
        ),
      ),
    );
  }
}
