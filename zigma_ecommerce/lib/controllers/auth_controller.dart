import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zigma_ecommerce/constants/consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

// text controller
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  // Login Method
  Future<UserCredential?> logInMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // User? user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // SignUp Method

  Future<UserCredential?> SignUpMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

// Stroring Data Method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(userCollections).doc(currentUser!.uid);

    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count' : '00',
      'order_count' : '00',
      'wishlist_count' : '00',
    });
  }

  // SignOut METHOD

  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
