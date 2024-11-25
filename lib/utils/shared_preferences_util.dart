import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils {
  // Save user details (like token and userId) to SharedPreferences
  static Future<void> saveUserData(String userId, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('token', token);
  }

  // Retrieve user data (userId and token) from SharedPreferences
  static Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    return {'userId': userId, 'token': token};
  }

  // Clear user data (when logging out or resetting)
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('token');
  }

  // Check if the user is logged in by checking the presence of token
  static Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }
}
