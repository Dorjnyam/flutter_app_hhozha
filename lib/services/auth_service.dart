import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class AuthService {
  // Login the user and return the token
  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> userData) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiLogin);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error occurred during login: $e');
    }
  }

  // Register a new user
  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiRegister);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error occurred during registration: $e');
    }
  }

// Reset the user's password
  Future<void> resetPassword(String email) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiResetPassword);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to send password reset email');
      }
    } catch (e) {
      throw Exception('Error occurred during password reset: $e');
    }
  }

  // Store the user's login token and other necessary data
  Future<void> storeUserData(String userId, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('token', token);
  }

  // Get stored user data (userId and token) from SharedPreferences
  Future<Map<String, String?>> getStoredUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    if (userId == null || token == null) {
      throw Exception('User not logged in');
    }

    return {'userId': userId, 'token': token};
  }

  // Logout the user by clearing stored data
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('token');
  }

  // Check if the user is logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    return userId != null && token != null;
  }
}