import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';
import '../../constants/api_constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _photoUrl;
  String? _username;
  String? _email;
  String? _firstName;
  String? _lastName;
  String? _registrationDate;

  bool _isLoading = true;
  String? _userId;
  String? _token;

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _token = prefs.getString('token');

    if (_userId == null || _token == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User ID or Token is missing')),
        );
      }
      return;
    }

    final url = Uri.parse('${ApiConstants.baseUrl}/users/1');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        setState(() {
          _firstName = userData['first_name'];
          _lastName = userData['last_name'];
          _email = userData['email'];
          _username = userData['username'];
          _registrationDate = userData['created_at'];
          _photoUrl = userData['photo_url'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch user data: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Fetch userId and token from SharedPreferences
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('userId');
                      final token = prefs.getString('token');

                      if (userId == null || token == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('User ID or Token is missing')),
                        );
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                            initialFirstName: _firstName,
                            initialLastName: _lastName,
                            initialPhotoUrl: _photoUrl,
                            userId: userId,
                            token: token,
                          ),
                        ),
                      ).then((updatedData) {
                        if (updatedData != null) {
                          setState(() {
                            _firstName = updatedData['first_name'];
                            _lastName = updatedData['last_name'];
                            _photoUrl = updatedData['photo_url'];
                          });
                        }
                      });
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _photoUrl != null
                          ? NetworkImage(_photoUrl!)
                          : const AssetImage('assets/placeholder.jpg')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _username ?? 'Username',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _email ?? 'Email',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _firstName ?? 'First Name',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _lastName ?? 'Last Name',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _registrationDate ?? 'Registration Date',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }
}
