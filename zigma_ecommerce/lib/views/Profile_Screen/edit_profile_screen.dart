import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/views/Profile_Screen/profile_controller.dart';
import 'package:zigma_ecommerce/widgets_common/bg.dart';
import 'package:zigma_ecommerce/widgets_common/custom_textfeild.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class EditProfileScrean extends StatelessWidget {
  final dynamic data;
  const EditProfileScrean({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // if data imageUrl and controller.path si empty
            data['imageUrl'] == '' && controller.profileImagePath.isEmpty
                ? Image.asset(imgProfile2, width: 150, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make()
                // if data is note empty but controller path is empty
                : data['imageUrl'] != '' && controller.profileImagePath.isEmpty
                    ? Image.network(data['imageUrl'],
                            width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make()
                    // if Both are empty
                    : Image.file(File(controller.profileImagePath.value),
                            width: 100, fit: BoxFit.cover)
                        .box
                        .roundedFull
                        .clip(Clip.antiAlias)
                        .make(),
            10.heightBox,

            // change Button
            ourButtonWidget(
                title: "Change",
                color: redColor,
                textColor: whiteColor,
                onPress: () {
                  controller.changeImage(context);
                }),
            const Divider(),
            20.heightBox,
            customeTextfeild(
                title: name,
                hint: nameHint,
                securePass: false,
                controller: controller.nameController),
            10.heightBox,

            customeTextfeild(
                title: oldpass,
                hint: passwordHint,
                securePass: true,
                controller: controller.oldPasswordController),
            10.heightBox,
            customeTextfeild(
                title: newpass,
                hint: passwordHint,
                securePass: true,
                controller: controller.newPasswordController),
            20.heightBox,
            controller.isloading.value
                ? loadingWidget()
                : SizedBox(
                    width: context.screenWidth - 60,

                    // Save Button
                    child: ourButtonWidget(
                        title: "Save",
                        color: redColor,
                        textColor: whiteColor,
                        onPress: () async {
                          controller.isloading(true);

                          // if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          // id old password mathes database

                          if (data['password'] ==
                                  controller.oldPasswordController.text &&
                              controller.newPasswordController.text == "") {
                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password:
                                    controller.oldPasswordController.text);
                            VxToast.show(context, msg: "Updated");
                          } else if (data['password'] ==
                                  controller.oldPasswordController.text &&
                              controller.newPasswordController.text != null) {
                            await controller.changeAuthPassword(
                                email: data['email'],
                                password: controller.oldPasswordController.text,
                                newPassword:
                                    controller.newPasswordController.text);
                            await controller.updateProfile(
                                name: controller.nameController.text,
                                password: controller.newPasswordController.text,
                                imgUrl: controller.profileImageLink);

                                VxToast.show(context, msg: "updated");
                            
                          }else{
                            VxToast.show(context, msg: "Wrong Old Password ");
                            controller.isloading(false);
                          }
                        }),
                  ),
          ],
        )
            .box
            .roundedSM
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .make(),
      ),
    ));
  }
}
