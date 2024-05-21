import 'package:get/get.dart';

import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/auth_controller.dart';
import 'package:zigma_seller/views/home_screen/home.dart';
import 'package:zigma_seller/widgets/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(icLogo, width: 80, height: 80)
                      .box
                      .border(color: whiteColor)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 22.0),
                ],
              ),
              60.heightBox,
              normalText(text: logInto, size: 18.0, color: lightGrey),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    textFormWidget(
                        prefix: Icons.email,
                        hintText: emailHint,
                        controller: controller.emailController),
                    10.heightBox,
                    textFormWidget(
                        prefix: Icons.lock,
                        hintText: passwordHint,
                        controller: controller.passwordController),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normalText(
                                text: forgotPassword, color: purpleColor))),
                    20.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isLoading.value
                            ? loadingIndicator()
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  controller.isLoading(true);
                                  await controller
                                      .logInMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged in");
                                      // controller.isLoading(false);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isLoading(false);
                                    }
                                  });
                                })),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget textFormWidget({prefix = Icons.email, hintText, controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        filled: true,
        fillColor: textfieldGrey,
        prefixIcon: Icon(
          prefix,
          color: purpleColor,
        ),
        border: InputBorder.none,
        hintText: hintText),
  );
}
