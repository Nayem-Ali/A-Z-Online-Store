import 'package:ecommerce/business_logic/bindings/auth_bindings.dart';
import 'package:ecommerce/business_logic/bindings/cart_bindings.dart';
import 'package:ecommerce/business_logic/bindings/favourite_bindings.dart';
import 'package:ecommerce/business_logic/bindings/splash_bindings.dart';
import 'package:ecommerce/ui/views/auth/forget_password.dart';
import 'package:ecommerce/ui/views/auth/registration.dart';
import 'package:ecommerce/ui/views/bottom_nav_controll.dart';
import 'package:ecommerce/ui/views/nav_pages/home.dart';
import 'package:ecommerce/ui/views/not_found.dart';
import 'package:ecommerce/ui/views/onboarding.dart';
import 'package:ecommerce/ui/views/splash.dart';
import 'package:ecommerce/ui/views/terms_condition.dart';
import 'package:get/get.dart';

import '../views/auth/login.dart';

const String splash = '/splash-screen';
const String unknown = '/not-found';
const String intro = '/intro';
const String login = '/login';
const String registration = '/registration';
const String forgetPass = '/forgetPass';
const String terms = '/terms';
const String bottomNav = '/bottomNav';
const String productDetails = '/productDetails';

List<GetPage> getPages = [
  GetPage(
    name: unknown,
    page: () => const Unknown(),
  ),
  GetPage(
    name: splash,
    page: () => const Splash(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: intro,
    page: () => const Onboarding(),
  ),
  GetPage(
    name: login,
    page: () => Login(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: registration,
    page: () => Registration(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: forgetPass,
    page: () => ForgetPassword(),
    binding: AuthBinding()
  ),
  GetPage(
    name: terms,
    page: () => const TermCondition(),
  ),
  GetPage(
    name: bottomNav,
    page: () => BottomNavController(),
    bindings: [FavouriteBindings(), CartBindings()]
  ), GetPage(
    name: productDetails,
    page: () => ProductDetails(),
  ),
];
