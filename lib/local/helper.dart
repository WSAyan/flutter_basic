import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  Future<void> setAuthToken(String authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(KEY_AUTH_TOKEN, authToken);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(KEY_AUTH_TOKEN) ?? "";
  }

  Future destroy() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

}

const KEY_AUTH_TOKEN = "_token";
const KEY_AUTH_EMAIL = "_email";
