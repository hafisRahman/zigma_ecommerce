import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    //  implement onInit

    getUsername();

    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = "";
  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(userCollections)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
