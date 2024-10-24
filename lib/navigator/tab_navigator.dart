import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/my_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/travel_page.dart';

import '../util/navigator_util.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        /// 禁止左右滑动
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blueAccent, // 底部tab label字体颜色
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('搜索', Icons.search, 1),
          _bottomItem('相机', Icons.camera_alt, 2),
          _bottomItem('我的', Icons.account_circle, 3)
        ],
      ),
    );
  }

  _bottomItem(String label, IconData icon, int index) {
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        label: label,
        activeIcon: Icon(icon, color: _activeColor));
  }
}
