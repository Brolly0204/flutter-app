import 'package:flutter_app/mvvm/main/controllers/controller.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}
