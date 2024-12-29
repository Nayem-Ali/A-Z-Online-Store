import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/favourites.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/cart.dart';
import '../model/products.dart';
import '../model/user_profile.dart';

class FirestoreDB {
  var box = GetStorage();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile() async {
    final auth = FirebaseAuth.instance;
    final snapshot = await _firebaseFirestore
        .collection('user')
        .where('email', isEqualTo: auth.currentUser!.email)
        .get();
    final userData = snapshot.docs.map((data) => UserProfile.fromSnapshot(data)).single;
    return userData;
  }

  Future<void> updateUserProfile(UserProfile user) async {
    await _firebaseFirestore
        .collection('user')
        .doc(user.email)
        .update(user.toJson())
        .then((value) => Get.snackbar("Success", "Profile Updated Successfully"));
  }

  Future<List<Products>> getProducts() async {
    try {
      final snapshot = await _firebaseFirestore.collection('products').get();
      final products = snapshot.docs.map((e) => Products.fromSnapshot(e)).toList();
      return products;
    } catch (e) {
      return [];
    }
  }

  Future<void> addToFavourite(Favourites favourite) async {
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.snackbar('Success', 'Added Successfully.'));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> checkFavourite(int productID) async* {
    yield* _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .where('id', isEqualTo: productID)
        .snapshots();
  }

  Future<List<Favourites>> getFavouriteItems() async {
    final snapshot = await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final favouriteData = snapshot.docs.map((e) => Favourites.fromSnapshot(e)).toList();
    return favouriteData;
  }

  Future<void> deleteFromFavourite(String? documentId) async {
    await _firebaseFirestore
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }

  Future<void> addToCart(Carts favourite) async {
    await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc()
        .set(favourite.toJson())
        .then((value) => Get.rawSnackbar(message: 'Added To Cart'));
  }

  Future<List<Carts>> getCartItems() async {
    final snapshot = await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .get();
    final cartData = snapshot.docs.map((e) => Carts.fromSnapshot(e)).toList();

    return cartData;
  }

  Future<void> deleteFromCart(String? documentId) async {
    await _firebaseFirestore
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('items')
        .doc(documentId)
        .delete()
        .then((value) => Get.snackbar('Success', 'Deleted Successfully.'));
  }

  Future<void> order(
      trxid, paymentId, merchantInvoiceNumber, customerMsisdn, executeTime, items, total) async {
    final user = box.read('user');
    await _firebaseFirestore.collection('orders').doc().set({
      'user_name': user['name'],
      'user_email': user['email'],
      'trxid': trxid,
      'paymentId': paymentId,
      'merchantInvoiceNumber': merchantInvoiceNumber,
      'customerMsisdn': customerMsisdn,
      'executeTime': executeTime,
      'items': FieldValue.arrayUnion(items),
      'total': total,
    }).then((value) => Get.rawSnackbar(message: 'Order placed successfully.'));
  }
}
