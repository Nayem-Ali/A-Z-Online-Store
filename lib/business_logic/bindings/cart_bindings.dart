import 'package:ecommerce/business_logic/controllers/cart_controller.dart';
import 'package:get/get.dart';

class CartBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(CartController());
  }

}