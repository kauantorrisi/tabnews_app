import 'package:shared_preferences/shared_preferences.dart';

class LogoutPrefsService {
  static const String _key = 'login';

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}
