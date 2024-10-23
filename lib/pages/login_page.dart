import 'package:flutter/material.dart';
import '../dao/login_dao.dart';
import '../util/navigator_util.dart';
import '../widget/login_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../util/string_util.dart';
import '../util/hi_space.dart';
import '../widget/input_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 防止键盘弹起背景图升起
      body: Stack(
        children: [..._Background(), _content()],
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
              userName = text;
              _checkInput();
            }),
            hiSpace(height: 10),
            InputWidget(
              '请输入密码',
              obscureText: true,
              onChanged: (text) {
                password = text;
                _checkInput();
              },
            ),
            hiSpace(height: 45),
            LoginWidget(
              '登录',
              enabled: loginEnable,
              onPressed: () {
                _login(context);
              },
            ),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: _jumpRegistration,
                child:
                    const Text('注册账号', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ));
  }

  _checkInput() {
    bool enabled;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enabled = true;
    } else {
      enabled = false;
    }
    setState(() {
      loginEnable = enabled;
    });
  }

  void _login(context) async {
    try {
      var result =
          await LoginDao.login(userName: userName!, password: password!);
      // var result = {
      //   "code": 0,
      //   "data": "3BADC81269BEDB546E244A7E98992F30TF",
      //   "msg": "login success."
      // };
      Future.delayed(const Duration(seconds: 2), () {
        NavigatorUtil.goToHome(context);
      });
      print('登陆成功');
    } catch (e) {
      print(e);
    }
  }

  void _jumpRegistration() async {
    Uri url = Uri.parse('https://m.sogou.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
