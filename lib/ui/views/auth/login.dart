import 'package:ecommerce/business_logic/controllers/auth_controller.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:ecommerce/ui/widgets/custom_button.dart';
import 'package:ecommerce/ui/widgets/custom_divider.dart';
import 'package:ecommerce/ui/widgets/custom_icon.dart';
import 'package:ecommerce/ui/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    obscureText: true,
                    suffixIcon: true,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => Get.toNamed(forgetPass),
                      child: Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200.w,
                    height: 45.h,
                    child: customButton('Login', () {
                      if (_formKey.currentState!.validate()) {
                        Get.find<AuthController>().login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          context,
                        );
                      } else {
                        Get.showSnackbar(AppStyles().failedSnackbar("Form Validation Failed"));
                      }
                    }),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      customDivider(),
                      const Text("  OR  "),
                      customDivider(),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 30),
                  Text.rich(TextSpan(children: [
                    const TextSpan(
                      text: "Don't have an account?",
                      style: TextStyle(color: AppColors.grayColor),
                    ),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.toNamed(registration),
                        text: "  Sign up",
                        style: const TextStyle(
                            color: AppColors.blackColor, fontWeight: FontWeight.w600))
                  ]))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
