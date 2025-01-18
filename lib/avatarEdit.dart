import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomizeAvatarScreen extends StatefulWidget {
  const CustomizeAvatarScreen({Key? key}) : super(key: key);

  @override
  _CustomizeAvatarScreenState createState() => _CustomizeAvatarScreenState();
}

class _CustomizeAvatarScreenState extends State<CustomizeAvatarScreen> {
  Color _avatarColor = Colors.blue;
  String? _avatarImagePath;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadAvatarSettings();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _saveAvatarSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('avatarColor', _avatarColor.value);
    await prefs.setString('avatarImagePath', _avatarImagePath ?? '');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avatar sauvegardé avec succès!')),
    );
  }

  Future<void> _loadAvatarSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _avatarColor = Color(prefs.getInt('avatarColor') ?? Colors.blue.value);
      _avatarImagePath = prefs.getString('avatarImagePath');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personnaliser l\'Avatar'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar Preview
            CircleAvatar(
              radius: 50,
              backgroundColor: _avatarColor,
              backgroundImage: _avatarImagePath != null
                  ? FileImage(File(_avatarImagePath!))
                  : null,
              child: _avatarImagePath == null
                  ? const Icon(Icons.person, size: 50, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),

            // Color Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Couleur :', style: TextStyle(fontSize: 16)),
                GestureDetector(
                  onTap: () => setState(() => _avatarColor = Colors.red),
                  child: const CircleAvatar(backgroundColor: Colors.red),
                ),
                GestureDetector(
                  onTap: () => setState(() => _avatarColor = Colors.green),
                  child: const CircleAvatar(backgroundColor: Colors.green),
                ),
                GestureDetector(
                  onTap: () => setState(() => _avatarColor = Colors.blue),
                  child: const CircleAvatar(backgroundColor: Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Image Picker
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text('Choisir une image'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            ),
            const SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveAvatarSettings,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Sauvegarder', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}





