import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://10.3.203.120:3000';
  // 'http://10.3.202.117:3000';

  // Register a new user
  Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users/register');
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
  }

  // Login user and retrieve the JWT token
  Future<Map<String, dynamic>> loginUser(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/users/login');
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
  }

  // Fetch user profile by user ID
  Future<Map<String, dynamic>> getUserProfile(
      String userId, String token) async {
    final url = Uri.parse('$baseUrl/users/$userId');
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

  // Add a transaction
  Future<Map<String, dynamic>> addTransaction(
      Map<String, dynamic> transactionData, String token) async {
    final url = Uri.parse('$baseUrl/transactions/add');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(transactionData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add transaction: ${response.body}');
    }
  }

  // Get transactions for a user
  Future<List<dynamic>> getTransactions(String userId, String token) async {
    final url = Uri.parse('$baseUrl/transactions/$userId');
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
      throw Exception('Failed to fetch transactions: ${response.body}');
    }
  }

  // Reset the user's password
  Future<Map<String, dynamic>> resetPassword(String email) async {
    final url = Uri.parse('$baseUrl/users/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset password: ${response.body}');
    }
  }

  // Update user profile (first name, last name, photo URL)
  Future<Map<String, dynamic>> updateUserProfile(
      String userId, String token, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/users/update/1');
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
      throw Exception('Failed to update user profile: ${response.body}');
    }
  }

  // Function to get user ID and token from SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? token = prefs.getString('token');

    return {'userId': userId, 'token': token};
  }
}
