import 'package:flutter/material.dart';
import 'package:flutter_app/navigator/tab_navigator.dart';
import './dao/login_dao.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import './util/screen_adapter_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          // primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            color: Colors.blueAccent,
            elevation: 4.0,
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18),
            shadowColor: Theme.of(context).colorScheme.shadow,
          ),
        ),
        // home: const LoginPage(),
        home: FutureBuilder<dynamic>(
            future: HiCache.preInit(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              ScreenHelper.init(context);
              if (snapshot.connectionState == ConnectionState.done) {
                if (LoginDao.getBoardingPass() != null) {
                  return const TabNavigator();
                }
                return const LoginPage();
              } else {
                return const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4.0,
                    backgroundColor: Colors.blue,
// value: 0.2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ));
              }
            }));
  }
}
