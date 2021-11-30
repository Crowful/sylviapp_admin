import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(String storeToken) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("storeToken", storeToken);
  }

  Future readCache(String storeToken) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    var cache = _preferences.getString("storeToken");
    return cache;
  }

  Future removeCache(String storeToken) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("storeToken");
  }
}
