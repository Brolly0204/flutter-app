import 'package:flutter_app/mvvm/login/controllers/controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
