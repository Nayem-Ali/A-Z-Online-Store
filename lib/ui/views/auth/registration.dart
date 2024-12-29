import 'package:ecommerce/business_logic/controllers/auth_controller.dart';
import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../const/app_colors.dart';
import '../../route/route.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text_field.dart';

class Registration extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  RxBool value = false.obs;

  final _formKey = GlobalKey<FormState>();

  // const Registration({Key? key}) : super(key: key);

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
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 50.w,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Signup',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  customFormField(
                    TextInputType.text,
                    _nameController,
                    context,
                    "Name",
                    (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      }
                    },
                    prefixIcon: Icons.person_2_outlined,
                  ),
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
                  customFormField(
                    TextInputType.text,
                    _passwordController,
                    context,
                    "Password",
                    (val) {
                      if (val.isEmpty) {
                        return 'This field cannot be empty';
                      } else if (val.length < 6) {
                        return 'Must be 6 characters long.';
                      }
                    },
                    prefixIcon: Icons.remove_red_eye_outlined,
                    suffixIcon: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: value.value,
                          onChanged: (val) {
                            value.value = val!;
                          },
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "I accept all the ",
                              style: TextStyle(color: AppColors.grayColor),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(terms),
                              text: "Term & Condition",
                              style: const TextStyle(
                                  color: AppColors.blackColor, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200.w,
                    height: 45.h,
                    child: customButton('Sign Up', () {
                      if (_formKey.currentState!.validate() && value.value) {
                        Get.find<AuthController>().signUp(
                          _nameController.text,
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          context,
                        );
                        // print("Success");
                      } else {
                        Get.showSnackbar(
                          AppStyles().failedSnackbar("Please provide data in right format"),
                        );
                        // Obx(()=>AppStyles().failedSnackbar("Please provide data in right format"));
                        print("Failed");
                      }
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      customDivider(),
                      const Text("  OR  "),
                      customDivider(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customIcon('assets/icons/facebook.png', () {}),
                      SizedBox(
                        width: 20.w,
                      ),
                      customIcon('assets/icons/search.png', () {})
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: AppColors.grayColor),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(login),
                          text: "  Login",
                          style: const TextStyle(
                              color: AppColors.blackColor, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
