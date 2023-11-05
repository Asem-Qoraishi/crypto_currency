import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String logedIn = 'login';

  Future<void> signUp() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(logedIn, true);
  }

  Future<bool?> isLogedIn() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(logedIn);
  }
}
