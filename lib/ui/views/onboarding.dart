import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/model/intro.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroScreenOnboarding(
          introductionList: introData
              .map((e) =>
              Introduction(
                imageHeight: 230.h,
                titleTextStyle: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w500),
                subTitleTextStyle: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w300),
                imageUrl: e.image,
                title: e.title,
                subTitle: e.description,
              ))
              .toList(),
          foregroundColor: AppColors.mandarinColor,
          onTapSkipButton: ()=> Get.toNamed(login),
        ),
      ),
    );
  }
}
