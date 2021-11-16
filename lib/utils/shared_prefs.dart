import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  late SharedPreferences _preferences;
  static const _userNameKey = "username";

  Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  Future setUserName(String userName) async {
    return await _preferences.setString(_userNameKey, userName);
  }

  String? getUserName() {
    return _preferences.getString(_userNameKey);
  }
}
