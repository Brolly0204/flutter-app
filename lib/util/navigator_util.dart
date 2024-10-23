import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widget/hi_webview.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../navigator/tab_navigator.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static updateContext(BuildContext context) {
    NavigatorUtil._context = context;
  }

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  ///返回上一页
  static pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      debugPrint('can');
      Navigator.pop(context);
    } else {
      //退出APP
      debugPrint('scan');
      SystemNavigator.pop();
    }
  }

  static jumpH5(
      {BuildContext? context,
      required String url,
      String? title,
      bool? hideAppBar,
      String? statusBarColor}) {
    BuildContext safeContext;
    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context!;
    } else {
      debugPrint('context is null jumpH5 failed');
      return;
    }
    Navigator.push(
        safeContext,
        MaterialPageRoute(
            builder: (context) => HiWebView(
                  url: url,
                  title: title,
                  hideAppBar: hideAppBar,
                  statusBarColor: statusBarColor,
                )));
  }

  static goToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const TabNavigator()));
  }

  static goToLogin() {
    Navigator.pushReplacement(
        _context!, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
