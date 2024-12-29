import 'package:ecommerce/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(String title, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColors.mandarinColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
        fontSize: 16.sp,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30),
    ),
    child: Text(title),
  );
}
