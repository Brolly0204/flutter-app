import 'package:flutter/material.dart';
import 'package:flutter_app/mvvm/binding/initialBinding.dart';
import 'package:flutter_app/mvvm/routes/app_pages.dart';
import 'package:flutter_app/navigator/tab_navigator.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import './dao/login_dao.dart';
import './pages/home_page.dart';
import './pages/login_page.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import './util/screen_adapter_helper.dart';

void main() {
  // initialization();
  runApp(const MyApp());
}

// void initialization() async {
//   WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//   FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
//   await Future.delayed(const Duration(microseconds: 500));
//   FlutterNativeSplash.remove();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      initialRoute: AppPages.init,
      initialBinding: InitialBinding(),
      getPages: AppPages.routes,
    );
  }

  Future<void> _doInit() async {
    await HiCache.preInit();
    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterSplashScreen.hide();
    });
  }
}
