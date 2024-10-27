import 'package:flutter/material.dart';
import 'package:flutter_app/mvvm/login/controllers/controller.dart';
import 'package:flutter_app/util/hi_space.dart';
import 'package:flutter_app/widget/input_widget.dart';
import 'package:flutter_app/widget/login_widget.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止键盘弹起背景图升起
      body: Stack(
        children: [..._Background(), Obx(() => _content())],
      ),
    );
  }

  List<Widget> _Background() {
    return [
      Positioned.fill(
          child: Image.asset('images/login-bg1.jpg', fit: BoxFit.cover)),
      Positioned.fill(
          child: Container(
        decoration: const BoxDecoration(color: Colors.black54),
      ))
    ];
  }

  _content() {
    return Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(
          children: [
            hiSpace(height: 100),
            const Text(
              '账号密码登录',
              style: TextStyle(fontSize: 26, color: Colors.white),
            ),
            hiSpace(height: 40),
            InputWidget('请输入账号', obscureText: false, onChanged: (text) {
              controller.onValueChanged(text, LoginInputType.username);
            }),
            hiSpace(height: 10),
            InputWidget(
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                controller.onValueChanged(text, LoginInputType.password);
              },
            ),
            hiSpace(height: 45),
            LoginWidget(
              '登录',
              enabled: controller.loginEnable.value,
              onPressed: () {
                controller.login();
              },
            ),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: controller.jumpRegistration,
                child:
                    const Text('注册账号', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ));
  }
}
