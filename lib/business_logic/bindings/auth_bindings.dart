import 'package:ecommerce/business_logic/controllers/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}