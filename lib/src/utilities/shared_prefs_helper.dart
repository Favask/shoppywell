import 'package:shared_preferences/shared_preferences.dart';


// shared_prefs_helper.dart
import 'package:shoppywell/src/utilities/constants.dart';

class SharedPrefsHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<String?> getString(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    await init();
    await _prefs?.setString(key, value);
  }

  static Future<void> clear() async {
    await init();
    await _prefs?.clear();
  }

  static Future<void> remove(String key) async {
    await init();
    await _prefs?.remove(key);
  }



  static Future<bool> checkFirstLaunch() async {
    await init();
    bool isFirstLaunch = _prefs?.getBool(Constants.keyFirstLaunch) ?? true;
    if (isFirstLaunch) {
      await _prefs?.setBool(Constants.keyFirstLaunch, false);
    }
    return isFirstLaunch;
  }

  static Future<void> resetFirstLaunch() async {
    await init();
    await _prefs?.setBool(Constants.keyFirstLaunch, true);
  }
} 
  

