import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
  }
}
