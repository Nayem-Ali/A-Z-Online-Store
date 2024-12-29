import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  signUp(name, email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.uid.isNotEmpty) {
        Map<String, dynamic> user = {
          "email": email,
          'uid': credential.user!.uid,
          'name': name,
        };
        CollectionReference collectionReference = _firestore.collection('user');
        collectionReference.doc(email).set(user);
        box.write('user', user);
        if (kDebugMode) {
          print(box.read('user'));
        }
        Get.back();
        Get.offAndToNamed(bottomNav);
        Get.showSnackbar(AppStyles().successSnackbar('SignUp Successful'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.showSnackbar(AppStyles().failedSnackbar('The password provided is too weak.'));
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.showSnackbar(AppStyles().failedSnackbar('The account already exists for that email.'));
        // print('The account already exists for that email.');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnackbar(e.toString()));
      // print(e);
    }
  }

  login(emailAddress, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user!.uid.isNotEmpty) {
        _firestore
            .collection('user')
            .doc(emailAddress)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> doc) {
          if (doc.exists) {
            var data = doc.data();
            if (kDebugMode) {
              print(data);
            }
            Map<String, dynamic> user = {
              "email": data!['email'],
              'uid': data['uid'],
              'name': data['name'],
            };
            box.write('user', user);
            print(user);
            Get.back();
            Get.offAndToNamed(bottomNav);
            Get.showSnackbar(AppStyles().successSnackbar('Login Successful'));
          } else {
            Get.back();
            Get.showSnackbar(AppStyles().failedSnackbar("Document does not exist"));
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        Get.showSnackbar(AppStyles().failedSnackbar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.showSnackbar(AppStyles().failedSnackbar('Wrong password provided for that user.'));
      }
    }
  }

  forgetPassword(emailAddress, context) async {
    try{
      AppStyles().progressDialog(context);
      await _auth.sendPasswordResetEmail(email: emailAddress);
      Get.back();
      Get.showSnackbar(AppStyles().successSnackbar("Password reset link sent to $emailAddress"));
    } catch (e){
      Get.back();
      Get.showSnackbar(AppStyles().failedSnackbar("Something went wrong: $e}"));
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
