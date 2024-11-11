import 'package:flutter/material.dart';
import 'auth_service.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'accueil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil sécurisée !'),
      ),
    );
  }
}
