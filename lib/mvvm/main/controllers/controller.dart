import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainViewModel extends GetxController {
  final currentIndex = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  void onBottomNavTap(int index) {
    currentIndex(index);
    pageController.jumpToPage(index);
  }
}
