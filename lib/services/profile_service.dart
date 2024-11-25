import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_constants.dart';

class ProfileService {
  // Fetch user profile by ID
  Future<Map<String, dynamic>> getUserProfile(
      String userId, String token) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.apiUserProfile}/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user profile: ${response.body}');
    }
  }

  // Update user profile (first name, last name, photo URL)
  Future<Map<String, dynamic>> updateUserProfile(
      String userId, String token, Map<String, dynamic> updatedData) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.apiUpdateProfile}$userId');
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  // Fetch and store user ID and token from SharedPreferences
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userId = prefs.getString('userId');

    if (token == null || userId == null) {
      throw Exception('User not logged in');
    }

    return {'token': token, 'userId': userId};
  }
}
