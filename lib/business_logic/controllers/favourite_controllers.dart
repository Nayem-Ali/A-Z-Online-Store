import 'package:ecommerce/model/products.dart';
import 'package:ecommerce/services/firestore_db.dart';
import 'package:get/get.dart';

import '../../model/favourites.dart';

class FavouriteControllers extends GetxController {
  RxList<Favourites> items = RxList<Favourites>([]);

  fetch() async {
    var favItems = await FirestoreDB().getFavouriteItems();
    items.value = favItems;
  }

  add(Products product) async {
    Favourites item = Favourites(
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
    await FirestoreDB().addToFavourite(item);
  }

  @override
  void onInit() {
    print('ad');
    fetch();
    super.onInit();
  }
}
