import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80.r,
              backgroundImage: const AssetImage(
                'assets/icons/artshop.jpg',
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              "ArtShop Sylhet",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.h,
              ),
            )
          ],
        ),
      ),
    );
  }
}
