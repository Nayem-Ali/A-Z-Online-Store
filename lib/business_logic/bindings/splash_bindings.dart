import 'package:ecommerce/business_logic/controllers/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(SplashController());
  }

}