import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final String? initialFirstName;
  final String? initialLastName;
  final String? initialPhotoUrl;
  final String userId;
  final String token;

  const EditProfileScreen({
    super.key,
    this.initialFirstName,
    this.initialLastName,
    this.initialPhotoUrl,
    required this.userId,
    required this.token,
  });

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String? _photoUrl;

  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  static const String _imgbbApiKey = 'a80bde7826f42077ff2761a732341126';
  static const String _imgbbApiUrl = 'https://api.imgbb.com/1/upload';

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.initialFirstName ?? '';
    _lastNameController.text = widget.initialLastName ?? '';
    _photoUrl = widget.initialPhotoUrl;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isUploading = true;
      });

      try {
        final uploadedUrl = await _uploadImageToImgBB(File(pickedFile.path));
        setState(() {
          _photoUrl = uploadedUrl;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image uploaded successfully!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image upload failed: $e')),
          );
        }
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<String> _uploadImageToImgBB(File imageFile) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse('$_imgbbApiUrl?key=$_imgbbApiKey'));
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseBody);
      return jsonResponse['data']['url'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  Future<void> _updateUserProfile(String userId, String token) async {
    final url = Uri.parse('http://192.168.15.107:3000/users/update/1');
    final updatedData = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'photo_url': _photoUrl,
    };

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
        }
        if (mounted) {
          Navigator.pop(context, responseBody['user']);
        }
      } else {
        throw Exception('Failed to update user profile: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _photoUrl != null
                        ? NetworkImage(_photoUrl!)
                        : const AssetImage('assets/placeholder.jpg')
                            as ImageProvider,
                    backgroundColor: Colors.grey[300],
                  ),
                  if (_isUploading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _updateUserProfile(widget.userId, widget.token);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
