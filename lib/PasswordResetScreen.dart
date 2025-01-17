import 'dart:convert';

import 'package:flutter/material.dart';
import 'auth_service.dart';

import 'package:http/http.dart' as http;

class PasswordResetScreen extends StatefulWidget {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

 Future<void> _resetPassword() async {
    final email = _emailController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez entrer votre email')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Afficher l'indicateur de chargement
    });
try {
  final response = await http.post(
    Uri.parse('http://192.168.14.50:3000/reset-password'),  // Remplacez par l'IP de votre serveur si nécessaire
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Un email de réinitialisation a été envoyé.')),
    );
  } else {
    final errorMessage = jsonDecode(response.body)['message'];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur: $errorMessage')),
    );
  }
} catch (error) {
  setState(() {
    _isLoading = false;
  });
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Erreur : ${error.toString()}')),
  );
}

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réinitialiser le mot de passe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Entrez votre adresse email pour recevoir un lien de réinitialisation',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Saisir email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
               keyboardType: TextInputType.emailAddress,

            ),
             SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _resetPassword,
                    child: Text('Réinitialiser le mot de passe'),
                  ),
          ],
        ),
      ),
    );
  }
}
