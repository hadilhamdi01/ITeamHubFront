import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  UpdateProfilePage({required this.userData});

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();
  String errorMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pseudoController.text = widget.userData['pseudo'];
    _emailController.text = widget.userData['email'];
    _avatarController.text = widget.userData['avatar'] ?? ''; // Default value if avatar is null
  }

  // Fonction pour récupérer le token depuis le stockage local
  Future<String> getTokenFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? ''; // Retourne le token ou une chaîne vide si non trouvé
  }

  // Fonction pour mettre à jour le profil de l'utilisateur
  Future<void> updateProfile() async {
    final String pseudo = _pseudoController.text;
    final String email = _emailController.text;
    final String avatar = _avatarController.text;

    setState(() {
      _isLoading = true;
    });

    // Récupérer le token depuis le stockage local
    String token = await getTokenFromStorage();

    // Vérifier si le token est valide
    if (token.isEmpty) {
      setState(() {
        errorMessage = 'Token manquant';
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.put(
        Uri.parse('http://192.168.14.50:3000/update-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Ajout de l'en-tête Authorization
        },
        body: json.encode({
          'pseudo': pseudo,
          'email': email,
          'avatar': avatar,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          errorMessage = data['message'];
        });
        // Vous pouvez rediriger vers une autre page ou afficher un message de succès
      } else {
        setState(() {
          errorMessage = 'Erreur lors de la mise à jour du profil';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erreur de connexion au serveur';
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
      appBar: AppBar(
        title: Text('Modifier le profil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _pseudoController,
              decoration: InputDecoration(
                labelText: 'Pseudo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _avatarController,
              decoration: InputDecoration(
                labelText: 'Avatar URL (optionnel)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : updateProfile,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Mettre à jour'),
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
