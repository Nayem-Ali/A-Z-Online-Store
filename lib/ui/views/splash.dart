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
            Image(
              image: const AssetImage(
                'assets/icons/logo.png',
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              "A-Z Online Store",
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
