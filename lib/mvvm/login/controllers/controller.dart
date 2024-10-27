import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dao/login_dao.dart';
import '../../../util/navigator_util.dart';

enum LoginInputType { username, password }

class LoginViewModel extends GetxController {
  final loginEnable = false.obs;
  String? userName;
  String? password;

  void onValueChanged(String value, LoginInputType type) {
    if (type == LoginInputType.username) {
      userName = value;
    } else {
      password = value;
    }
    loginEnable(userName != null &&
        userName!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty);
  }

  login() async {
    try {
      var result =
          await LoginDao.login(userName: userName!, password: password!);
      Future.delayed(const Duration(seconds: 2), () {
        NavigatorUtil.goToHome(null);
      });
      debugPrint('登陆成功');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  jumpRegistration() async {
    Uri url = Uri.parse('https://m.sogou.com/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
