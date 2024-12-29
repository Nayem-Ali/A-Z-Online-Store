import 'package:ecommerce/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget customFormField(
  keyboardType,
  controller,
  context,
  hintText,
  validator, {
  bool obscureText = false,
  prefixIcon,
  readOnly = false,
  suffixIcon=false,
}) {
  RxBool obsecure = obscureText.obs;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Obx(()=>TextFormField(
      keyboardType: keyboardType,
      readOnly: readOnly,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      obscureText: obsecure.value,
      textInputAction: TextInputAction.next,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?  IconButton(
          onPressed: () {
            obsecure.value = !obsecure.value;
          },
          icon: Icon(obsecure.value ? Icons.visibility : Icons.visibility_off),
        ) : const SizedBox(),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 5,
            top: 5,
            bottom: 5,
            right: 10,
          ),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFDF2EE),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              prefixIcon,
              color: AppColors.mandarinColor,
              size: 20,
            ),
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.r),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    )),
  );
}
