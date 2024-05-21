import 'package:zigma_seller/constants/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return firestore
        .collection(orderCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return firestore
        .collection(productsCollection)
        .where('vender_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return firestore
  //       .collection(productsCollection)
  //       .where('vender_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
