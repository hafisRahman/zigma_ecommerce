import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';
import 'package:zigma_ecommerce/views/Home_Screen/home.dart';
import 'package:zigma_ecommerce/views/auth_Screan/login_screan.dart';
import 'package:zigma_ecommerce/widgets_common/applogo.dart';

class SplashScrean extends StatefulWidget {
  const SplashScrean({super.key});

  @override
  State<SplashScrean> createState() => _SplashScreanState();
}

class _SplashScreanState extends State<SplashScrean> {
// Method to change screan

  changeScrean() {
    Future.delayed(const Duration(seconds: 3), () {
      
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(()=> const LogInScrean());
        }else{
          Get.to(()=> const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScrean();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: violet,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(icSplashBg, width: 300),
            ),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            appversion.text.white.make(),
            const Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //Splash screan UI Completed
          ],
        ),
      ),
    );
  }
}
