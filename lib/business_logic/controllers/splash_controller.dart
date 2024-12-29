import 'dart:async';
import 'package:ecommerce/ui/route/route.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController{
  final _box = GetStorage();

  chooseScreen() {
    var value = _box.read('user');
    print(value);
    if(value == null){
      Get.offAndToNamed(intro);
    }else{
      Get.offAndToNamed(bottomNav);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    Timer(const Duration(seconds: 3), () => chooseScreen());
    super.onInit();
  }

}