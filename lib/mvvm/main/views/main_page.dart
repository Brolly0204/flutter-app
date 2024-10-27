import 'package:flutter/material.dart';
import 'package:flutter_app/mvvm/main/views/bottom_tab_view.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

import '../../../dao/login_dao.dart';
import '../../../pages/login_page.dart';
import '../../../util/screen_adapter_helper.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: _doInit(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          ScreenHelper.init(context);
          if (snapshot.connectionState == ConnectionState.done) {
            if (LoginDao.getBoardingPass() != null) {
              return const BottomTabView();
            }
            return const LoginPage();
          } else {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                backgroundColor: Colors.blue,
//                     valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ));
          }
        });
  }

  Future<void> _doInit() async {
    await HiCache.preInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterSplashScreen.hide();
    });
  }
}
