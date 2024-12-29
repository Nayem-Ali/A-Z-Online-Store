import 'package:ecommerce/business_logic/controllers/favourite_controllers.dart';
import 'package:get/get.dart';

class FavouriteBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FavouriteControllers());
  }
}
