import 'dart:io';

import 'package:get/get.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/profile_controller.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    controller.nameController.text = widget.username!;
    
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: boldText(
            text: editProfile,
          ),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: whiteColor)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      // if image is not selected
                      if (controller.profileImagePath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      // id old password mathes database

                      if (controller.snapshotData['password'] ==
                          controller.oldPasswordController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldPasswordController.text,
                            newPassword: controller.newPasswordController.text);
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.newPasswordController.text,
                            imgUrl: controller.profileImageLink);

                        VxToast.show(context, msg: "updated");
                      } else if (controller.snapshotData['password'] ==
                              controller.oldPasswordController.text &&
                          controller.newPasswordController.text == "") {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                        VxToast.show(context,
                            msg: "Updated without changing password and name");
                      } else {
                        VxToast.show(context, msg: "Wrong Old Password ");
                        controller.isloading(false);
                      }

                      // if (controller.oldPasswordController.text.isEmptyOrNull &&
                      //     controller.newPasswordController.text.isEmptyOrNull) {
                      //   await controller.updateProfile(
                      //       imgUrl: controller.profileImageLink,
                      //       name: controller.nameController.text,
                      //       password: controller.snapshotData['password']);
                      //   VxToast.show(context,
                      //       msg: "Updated without changing password and name");
                      // } else if (controller.snapshotData['password'] ==
                      //     controller.oldPasswordController.text) {
                      //   await controller.changeAuthPassword(
                      //       email: controller.snapshotData['email'],
                      //       password: controller.oldPasswordController.text,
                      //       newPassword: controller.newPasswordController.text);
                      //   await controller.updateProfile(
                      //       name: controller.nameController.text,
                      //       password: controller.newPasswordController.text,
                      //       imgUrl: controller.profileImageLink);

                      //   VxToast.show(context, msg: "updated");
                      // } else {
                      //   VxToast.show(context, msg: "Wrong Old Password ");
                      //   controller.isloading(false);
                      // }
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
              // if data imageUrl and controller.path si empty
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImagePath.isEmpty
                  ? Image.asset(imgProduct, width: 150, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                  // if data is note empty but controller path is empty
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImagePath.isEmpty
                      ? Image.network(controller.snapshotData['imageUrl'],
                              width: 150, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      // if Both are empty
                      : Image.file(File(controller.profileImagePath.value),
                              width: 150, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),

              10.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: whiteColor),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: changeImage, color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: whiteColor,
              ),
              10.heightBox,
              customTextFeild(
                  label: name,
                  hint: nameHint,
                  controller: controller.nameController),
              30.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child:
                      boldText(text: "Change your password", color: lightGrey)),
              10.heightBox,
              customTextFeild(
                  label: password,
                  hint: passwordHint,
                  securePass: true,
                  controller: controller.oldPasswordController),
              10.heightBox,
              customTextFeild(
                  label: newmPass,
                  hint: passwordHint,
                  securePass: true,
                  controller: controller.newPasswordController),
            ],
          ),
        ),
      ),
    );
  }
}
