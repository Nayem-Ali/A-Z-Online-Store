import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppStyles{
  //Loading
  progressDialog(context){
    showDialog(context: context, builder: (_){
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset('assets/files/loading.gif',height: 150.h,),
      );
    });
  }

  // failed snackbar
  GetSnackBar failedSnackbar(message) => GetSnackBar(
    message: message,
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.warning),
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
  );

  // success snackbar
  GetSnackBar successSnackbar(message) => GetSnackBar(
    message: message,
    duration: const Duration(seconds: 2),
    icon: const Icon(Icons.assignment_turned_in),
    backgroundColor: Colors.green,
    snackPosition: SnackPosition.BOTTOM,
  );
}
