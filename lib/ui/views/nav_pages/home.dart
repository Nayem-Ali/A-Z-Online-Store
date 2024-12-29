import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/business_logic/controllers/cart_controller.dart';
import 'package:ecommerce/business_logic/controllers/favourite_controllers.dart';
import 'package:ecommerce/model/products.dart';
import 'package:ecommerce/services/firestore_db.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:ecommerce/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
      child: RefreshIndicator(
        onRefresh: () => FirestoreDB().getProducts(),
        child: FutureBuilder(
          future: FirestoreDB().getProducts(),
          builder: (_, snapshot) {
            // print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () => Get.toNamed(productDetails, arguments: snapshot.data![index]),
                      child: Ink(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.mandarinColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.grayColor.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data![index].thumbnail,
                                height: 100,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(Icons.adb),
                              ),
                            ),
                            Text(
                              snapshot.data![index].title,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '\$ ${snapshot.data![index].price}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  ProductDetails({Key? key}) : super(key: key);
  final Products data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirestoreDB().checkFavourite(data.id),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              return IconButton(
                onPressed: () async {
                  if (snapshot.data!.docs.isNotEmpty) {
                    Get.showSnackbar(
                      AppStyles().failedSnackbar(
                        "Item is Already Added to the Favourites",
                      ),
                    );
                  } else {
                    await Get.find<FavouriteControllers>().add(data);
                  }
                },
                icon: Icon(
                  snapshot.data!.docs.isNotEmpty ? Icons.favorite : Icons.favorite_outline,
                  color: AppColors.mandarinColor,
                  size: 40.w,
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: data.images[index],
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(Icons.error, size: 200),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text(
              data.title,
              style: txtStyle(16, FontWeight.bold, AppColors.blackColor),
            ),
            Text(
              data.description,
              style: txtStyle(14, FontWeight.w400, AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Price: \$ ${data.price}",
                  style: txtStyle(18, FontWeight.bold, AppColors.mandarinColor),
                ),
                customButton("Add to Cart", () async {
                  await Get.find<CartController>().add(data);
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Discount: ${data.discountPercentage}%",
                  style: txtStyle(
                    14,
                    FontWeight.bold,
                    Colors.teal,
                  ),
                ),
                Text(
                  "Rating: ${data.rating}",
                  style: txtStyle(
                    14,
                    FontWeight.w800,
                    Colors.indigoAccent,
                  ),
                ),
                Text(
                  "Stock: ${data.stock}",
                  style: txtStyle(
                    14,
                    FontWeight.w800,
                    Colors.blueGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

txtStyle(double fontSize, fontWeight, color) =>
    TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
