import '../model/home_model.dart';
import '../model/json/home.dart';

class HomeDao {
  static Future<HomeModel?> fetch() async {
    await Future.delayed(const Duration(seconds: 1));
    return HomeModel.fromJson(homeModelJson);
  }
}
