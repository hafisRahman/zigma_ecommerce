import 'dart:ffi';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zigma_seller/constants/const.dart';
import 'package:zigma_seller/controllers/home_controller.dart';
import 'package:zigma_seller/views/Orders_screen/orders_screen.dart';
import 'package:zigma_seller/views/Products_screen/products_screen.dart';
import 'package:zigma_seller/views/home_screen/home_screen.dart';
import 'package:zigma_seller/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProducts,
          color: darkFontGrey,
          width: 24,
        ),
        label: products,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkFontGrey,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            width: 24,
            color: darkFontGrey,
          ),
          label: settings),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkFontGrey,
            items: bottomNavBar),
      ),
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: navScreens.elementAt(controller.navIndex.value)))
        ],
      ),
    );
  }
}
