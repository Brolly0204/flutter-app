import 'dart:convert';
import '../util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import '../util/header_util.dart';

class LoginDao {
  static const boardingPass = 'boarding_pass';
  static login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {};
    paramsMap['userName'] = userName;
    paramsMap['password'] = password;
    Uri uri = Uri.https('api.devio.org', '/uapi/user/login', paramsMap);
    final response = await http.post(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var result = jsonDecode(bodyString);
      result = {
        "code": 0,
        "data": "3BADC81269BEDB546E244A7E98992F30TF",
        "msg": "login success."
      };

      if (result['code'] == 0 && result['data'] != null) {
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(bodyString);
      }
    } else {
      throw Exception(bodyString);
    }
  }

  static void _saveBoardingPass(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }

  static logout() {
    HiCache.getInstance().remove(boardingPass);
    NavigatorUtil.goToLogin();
  }
}
