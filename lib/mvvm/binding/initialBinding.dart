import 'package:flutter_app/mvvm/login/binding/login_binding.dart';
import 'package:flutter_app/mvvm/main/binding/main_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    MainBinding().dependencies();
    LoginBinding().dependencies();
  }
}
