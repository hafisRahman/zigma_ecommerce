import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/controllers/auth_controller.dart';
import 'package:zigma_ecommerce/views/Home_Screen/home.dart';
import 'package:zigma_ecommerce/widgets_common/applogo.dart';
import 'package:zigma_ecommerce/widgets_common/bg.dart';
import 'package:zigma_ecommerce/widgets_common/custom_textfeild.dart';
import 'package:zigma_ecommerce/widgets_common/loading_widget.dart';
import 'package:zigma_ecommerce/widgets_common/ourButton.dart';

class SignUpScrean extends StatefulWidget {
  const SignUpScrean({super.key});

  @override
  State<SignUpScrean> createState() => _SignUpScreanState();
}

class _SignUpScreanState extends State<SignUpScrean> {
  bool? isCheck = false;

  var controller = Get.put(AuthController());

  // text controller

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Welcome to  $appname".text.fontFamily(bold).size(22).white.make(),
            15.heightBox,
            Obx(() => Column(
                children: [
                  customeTextfeild(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      securePass: false),
                  customeTextfeild(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      securePass: false),
                  customeTextfeild(
                      title: password,
                      hint: passwordHint,
                      controller: passwordController,
                      securePass: true),
                  customeTextfeild(
                      title: confPassword,
                      hint: passwordHint,
                      controller: confPasswordController,
                      securePass: true),

                  Row(
                    children: [
                      //checkbox
                      Checkbox(
                        checkColor: redColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I Agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: termsAndConditns,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              )),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: bold,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ))
                        ])),
                      )
                    ],
                  ),
                  //SignUp Button

                  controller.isLoading.value
                      ? loadingWidget()
                      : ourButtonWidget(
                          color: isCheck == true ? redColor : lightGrey,
                          textColor: whiteColor,
                          title: singnUp,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isLoading(true);
                              try {
                                await controller.SignUpMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: logdIn);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isLoading(false);
                              }
                            }
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text.color(redColor).make().onTap(() {
                        Get.back();
                      })
                    ],
                  )
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
