import 'package:flutter/material.dart';
import 'package:flutter_app/mvvm/main/controllers/controller.dart';
import 'package:get/get.dart';

import '../../../pages/home_page.dart';
import '../../../pages/my_page.dart';
import '../../../pages/search_page.dart';
import '../../../pages/travel_page.dart';

class BottomTabView extends GetView<MainViewModel> {
  const BottomTabView({super.key});
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            /// 禁止左右滑动
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
          ),
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.blueAccent, // 底部tab label字体颜色
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.currentIndex.value,
            onTap: controller.onBottomNavTap,
            items: [
              _bottomItem('首页', Icons.home, 0),
              _bottomItem('搜索', Icons.search, 1),
              _bottomItem('相机', Icons.camera_alt, 2),
              _bottomItem('我的', Icons.account_circle, 3)
            ],
          ),
        ));
  }

  _bottomItem(String label, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        label: label,
        activeIcon: Icon(icon, color: _activeColor));
  }
}
