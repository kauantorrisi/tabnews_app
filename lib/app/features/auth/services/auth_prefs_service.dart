import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefsService {
  static const String _key = 'login';
  static String? token;
  static String? email;
  static String? username;
  static int? tabCoins;
  static int? tabCash;
  static const bool isGuest = false;

  static void save({
    required String token,
    required String email,
    required String username,
    required int tabCoins,
    required int tabCash,
    required bool isGuest,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _key,
      jsonEncode({
        "token": token,
        "email": email,
        "username": username,
        "tabCoins": tabCoins,
        "tabCash": tabCash,
        "isGuest": isGuest,
        "isAuth": true
      }),
    );
  }

  Future<bool> isAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonResult = prefs.getString(_key);
    if (jsonResult != null) {
      var mapUser = jsonDecode(jsonResult);
      token = mapUser["token"];
      email = mapUser["email"];
      username = mapUser["username"];
      tabCoins = mapUser["tabCoins"];
      tabCash = mapUser["tabCash"];
      return mapUser["isAuth"];
    }
    return false;
  }
}
