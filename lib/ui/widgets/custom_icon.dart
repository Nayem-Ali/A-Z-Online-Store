import 'package:flutter/material.dart';

import '../../const/app_colors.dart';

Widget customIcon(String assetPath, Function() onTap){
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50),
    child: Ink(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.grayColor.withOpacity(0.5),
            blurRadius: 7,
            spreadRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(assetPath),
      ),
    ),
  );
}