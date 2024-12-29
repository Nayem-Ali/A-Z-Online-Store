import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/ui/views/nav_pages/cart.dart';
import 'package:ecommerce/ui/views/nav_pages/favourite.dart';
import 'package:ecommerce/ui/views/nav_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'nav_pages/home.dart';

class BottomNavController extends StatelessWidget {
  BottomNavController({Key? key}) : super(key: key);
  final RxInt _currentIndex = 0.obs;
  final _pages = [const Home(), const Favourite(), Cart(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60.h),
          child: AppBar(
            title: const Text(
              "ART Shop SYL",
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
            backgroundColor: AppColors.mandarinColor,
            actions: [
              SizedBox(
                height: 45.h,
                width: 45.w,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/facebook.png'),
                ),
              ),
              SizedBox(
                height: 55.h,
                width: 55.w,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/whatsapp.png'),
                ),
              ),
              SizedBox(
                height: 45.h,
                width: 45.w,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icons/Instagram.png'),
                ),
              ),
            ],
          ),
        ),
        body: _pages[_currentIndex.value],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex.value,
          onTap: (val) {
            _currentIndex.value = val;
          },
          backgroundColor: AppColors.whiteColor,
          selectedItemColor: AppColors.mandarinColor,
          items: [
            bottomBarItem(Icons.home, 'Home'),
            bottomBarItem(Icons.favorite, 'Favourite'),
            bottomBarItem(Icons.shopping_bag_outlined, 'Cart'),
            bottomBarItem(Icons.person_outlined, 'Person'),
          ],
        ),
      ),
    );
  }
}

SalomonBottomBarItem bottomBarItem(icon, title) =>
    SalomonBottomBarItem(icon: Icon(icon), title: Text(title));
