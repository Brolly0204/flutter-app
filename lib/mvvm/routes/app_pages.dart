import 'package:flutter_app/mvvm/login/binding/login_binding.dart';
import 'package:flutter_app/mvvm/login/views/login_page.dart';
import 'package:flutter_app/mvvm/main/binding/main_binding.dart';
import 'package:flutter_app/mvvm/main/views/main_page.dart';
import 'package:get/get.dart';

part './app_routes.dart';

class AppPages {
  AppPages._();
  static const init = Routes.MAIN;
  static final routes = [
    GetPage(
        name: Routes.MAIN,
        page: () => const MainPage(),
        binding: MainBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginPage(), binding: LoginBinding())
  ];
}
