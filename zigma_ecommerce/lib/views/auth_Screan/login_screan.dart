import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/constants/lists.dart';
import 'package:zigma_ecommerce/controllers/auth_controller.dart';
import 'package:zigma_ecommerce/views/Home_Screen/home.dart';
import 'package:zigma_ecommerce/views/auth_Screan/signup_screan.dart';
import 'package:zigma_ecommerce/widgets_common/applogo.dart';
import 'package:zigma_ecommerce/widgets_common/bg.dart';
import 'package:zigma_ecommerce/widgets_common/custom_textfeild.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class LogInScrean extends StatelessWidget {
  const LogInScrean({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).size(22).white.make(),
            15.heightBox,
            Obx(() => Column(
                children: [
                  customeTextfeild(
                      title: email,
                      hint: emailHint,
                      controller: controller.emailController,
                      securePass: false),
                  customeTextfeild(
                      title: password,
                      hint: passwordHint,
                      controller: controller.passwordController,
                      securePass: true),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {}, child: forgetPass.text.make())),
                  5.heightBox,
                  //LogIn Button
                  controller.isLoading.value
                      ? loadingWidget()
                      : ourButtonWidget(
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .logInMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: logdIn);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                              color: redColor,
                              textColor: whiteColor,
                              title: login)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),

                  5.heightBox,
                  creatNewAccnt.text.color(fontGrey).make(),
                  5.heightBox,
                  //SignUp Button
                  ourButtonWidget(
                          onPress: () {
                            Get.to(const SignUpScrean());
                          },
                          color: golden,
                          textColor: redColor,
                          title: singnUp)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  logInWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialList[index],
                                      width: 30,
                                    )),
                              )))
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
