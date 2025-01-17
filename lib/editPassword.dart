import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPass extends StatefulWidget {
  const EditPass({Key? key, required this.userData, required this.authToken}) : super(key: key);

  final Map<String, dynamic> userData;
  final String authToken;

  @override
  _EditPassState createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _updatePassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      setState(() {
        _errorMessage = 'Les mots de passe ne correspondent pas.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.put(
        Uri.parse('http://192.168.14.50:3000/update-password'),
        headers: {
          'Authorization': 'Bearer ${widget.authToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _errorMessage = 'Mot de passe modifié avec succès.';
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          _errorMessage = data['message'] ?? 'Erreur lors de la modification.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Une erreur est survenue. Veuillez réessayer.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: const Text(
          "Changer le mot de passe",
          style: TextStyle(
            color: Color.fromARGB(255, 254, 252, 252),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.blue,
                  backgroundImage: AssetImage(widget.userData['avatar'] ?? ''),
                ),
                const SizedBox(width: 10),
                Text(
                  "u/${widget.userData['pseudo'] ?? 'Utilisateur'}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _oldPasswordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe actuel',
                labelStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.visibility, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _newPasswordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nouveau mot de passe',
                labelStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.visibility, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              style: const TextStyle(color: Colors.white),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmer le nouveau mot de passe',
                labelStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.visibility, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Annuler',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Enregistrer',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
