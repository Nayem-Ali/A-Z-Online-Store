import 'package:ecommerce/business_logic/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPassword extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();

  // const ForgetPassword({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 50.w,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  customFormField(
                    TextInputType.text,
                    _emailController,
                    context,
                    "Email",
                    (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (val.contains('@') == false) {
                        return 'Email is not valid';
                      }
                    },
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200.w,
                    height: 45.h,
                    child: customButton('Continue', () {
                      if (_formKey.currentState!.validate()) {
                        Get.find<AuthController>().forgetPassword(
                          _emailController.text.trim(),
                          context,
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
