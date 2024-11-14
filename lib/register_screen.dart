import 'package:flutter/material.dart';
import 'auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

// RegisterScreen.dart
void _goToPseudoScreen() {
  Navigator.pushNamed(
    context,
    '/pseudo',
    arguments: {
      'email': _emailController.text,
      'password': _passwordController.text,
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscription')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToPseudoScreen,
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}
