import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefsService {
  static const String _key = 'login';
  static String? token;
  static const bool isGuest = false;

  static void save({
    required String token,
    required bool isGuest,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _key,
      jsonEncode({"token": token, "isGuest": isGuest, "isAuth": true}),
    );
  }

  Future<bool> isAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      token = mapUser["token"];
      return mapUser["isAuth"];
    }
    return false;
  }
}
