import 'package:paypara/core/constants/enums/preferences_keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleManager {
  static LocaleManager _instance = LocaleManager._init();

  SharedPreferences _preferences;
  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then(
      (value) => {_preferences = value},
    );
  }

  static preferencesInit() async {
    if (instance._preferences == null) {
      instance._preferences = await SharedPreferences.getInstance();
    }
    return;
  }

  Future<void> setString(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  String getString(PreferencesKeys key) {
    try {
      if (_preferences.getString(key.toString()) == null) {
        return "";
      } else {
        return _preferences.getString(key.toString()).toString();
      }
    } catch (e) {
      return "";
    }
  }

  Future<void> setBool(PreferencesKeys key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  bool getBool(PreferencesKeys key) => _preferences.getString(key.toString()) ?? false;

  Future<void> removeAllSharedPreferences() async {
    await _preferences.clear();
  }
}
