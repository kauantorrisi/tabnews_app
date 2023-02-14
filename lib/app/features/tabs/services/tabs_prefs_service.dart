import 'package:shared_preferences/shared_preferences.dart';

class TabsPrefsService {
  static const String _key = 'login';

  static Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_key);
  }
}
