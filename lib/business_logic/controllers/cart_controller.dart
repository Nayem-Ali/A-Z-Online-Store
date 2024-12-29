import 'package:ecommerce/model/products.dart';
import 'package:ecommerce/services/firestore_db.dart';
import 'package:get/get.dart';

import '../../model/cart.dart';

class CartController extends GetxController {
  RxList<Carts> items = RxList<Carts>([]);

  fetch() async {
    var cartItems = await FirestoreDB().getCartItems();
    items.value = cartItems;
  }

  add(Products product) async {
    Carts item = Carts(
      brand: product.brand,
      category: product.category,
      description: product.description,
      discountPercentage: product.discountPercentage,
      id: product.id,
      images: product.images,
      price: product.price,
      rating: product.rating,
      stock: product.stock,
      thumbnail: product.thumbnail,
      title: product.title,
    );
    await FirestoreDB().addToCart(item);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetch();
    super.onInit();
  }

  num get getTotal => items.fold(0, (previousValue, element) => previousValue + element.price);

}
