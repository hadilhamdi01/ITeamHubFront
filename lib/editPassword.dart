import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditPass extends StatefulWidget {
  const EditPass({Key? key, required this.userData, required this.onLogout}) : super(key: key);

  final Map<String, dynamic> userData;
  final VoidCallback onLogout;

  @override
  _EditPassState createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  Future<String> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<void> _updatePassword() async {
    if (_oldPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez remplir tous les champs.';
      });
      return;
    }

    if (_newPasswordController.text.length < 6) {
      setState(() {
        _errorMessage = 'Le nouveau mot de passe doit contenir au moins 6 caractères.';
      });
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Les nouveaux mots de passe ne correspondent pas.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      String token = await getTokenFromStorage();

      if (token.isEmpty) {
        setState(() {
          _errorMessage = 'Token introuvable. Veuillez vous reconnecter.';
          _isLoading = false;
        });
        widget.onLogout();
        return;
      }

      final response = await http.put(
        Uri.parse('http://192.168.14.50:3000/update-password'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'oldPassword': _oldPasswordController.text,
          'newPassword': _newPasswordController.text,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _successMessage = 'Mot de passe modifié avec succès.';
          _oldPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        });
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else if (response.statusCode == 403) {
        setState(() {
          _errorMessage = 'Session expirée. Veuillez vous reconnecter.';
        });
        widget.onLogout();
      } else {
        final data = json.decode(response.body);
        setState(() {
          _errorMessage = data['message'] ?? 'Une erreur s\'est produite.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erreur de connexion au serveur.';
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
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
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
                const SizedBox(width: 30),
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
            ..._buildPasswordFields(),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (_successMessage != null)
              Text(
                _successMessage!,
                style: const TextStyle(color: Colors.green),
              ),
            const SizedBox(height: 50),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Annuler',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _updatePassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: const Text(
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

  List<Widget> _buildPasswordFields() {
    return [
      _buildPasswordField('Mot de passe actuel', _oldPasswordController, _obscureOldPassword, () {
        setState(() {
          _obscureOldPassword = !_obscureOldPassword;
        });
      }),
      const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
Navigator.pushNamed(context, '/password-reset');              },
              child: const Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
      const SizedBox(height: 20),
      _buildPasswordField('Nouveau mot de passe', _newPasswordController, _obscureNewPassword, () {
        setState(() {
          _obscureNewPassword = !_obscureNewPassword;
        });
      }),
      
      const SizedBox(height: 20),
      _buildPasswordField('Confirmer le nouveau mot de passe', _confirmPasswordController, _obscureConfirmPassword, () {
        setState(() {
          _obscureConfirmPassword = !_obscureConfirmPassword;
        });
      }),
    ];
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
