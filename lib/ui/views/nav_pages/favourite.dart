import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/business_logic/controllers/favourite_controllers.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/services/firestore_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final controller = Get.find<FavouriteControllers>();

  @override
  Widget build(BuildContext context) {
    controller.fetch();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: controller.items.isEmpty
          ? const Center(
              child: Text("No Item Found"),
            )
          : Obx(
              () => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (_, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Ink(
                          height: 200,
                          width: double.maxFinite,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.grayColor.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.items[index].thumbnail,
                                height: 100,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) => Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                              Text(
                                controller.items[index].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '\$ ${controller.items[index].price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            FirestoreDB().deleteFromFavourite(controller.items[index].documentID);
                            controller.fetch();
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
    );
  }
}
