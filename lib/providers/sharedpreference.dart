import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
// createCache(String storeToken) async {
//     SharedPreferences _preferences = await SharedPreferences.getInstance();
//     _preferences.setString("storeToken", storeToken);
//   }

//   Future readCache(String storeToken) async {
//     SharedPreferences _preferences = await SharedPreferences.getInstance();
//     var cache = _preferences.getString("storeToken");
//     return cache;
//   }

//   Future<void> removeCache(String storeToken) async {
//     SharedPreferences _preferences = await SharedPreferences.getInstance();
//     _preferences.remove(storeToken);
//   }
  dynamic getString(key) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? _res = prefs.getString(key);
    return _res;
  }

  dynamic putString(String key, String val) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var _res = prefs.setString(key, val);
    return _res;
  }

  Future reset() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
