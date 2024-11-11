import 'package:flutter/material.dart';
import 'auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  Color _buttonColor = const Color.fromARGB(139, 158, 158, 158); // Couleur initiale


  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final success = await _authService.login(email, password);
      
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la connexion. Veuillez réessayer.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Reddit Icon
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/reddit_icon.png'), 
            ),
            SizedBox(height: 20),
            // "Saisis tes informations de connexion" Text
            Text(
              'Saisis tes informations de connexion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Email Input Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Saisir email ou pseudo',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Password Input Field
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Saisir mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            // "Mot de passe oubliée?" link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  // Add password recovery functionality here
                },
                child: Text(
                  'Mot de passe oubliée ?',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Agreement Text
            Text(
              "En continuant, tu acceptes notre Contrat d'utilisation et confirmes que tu comprends notre Politiques de confidentialité.",
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Continue Button
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: _buttonColor, // Adjust color as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: Text(
                'Se connecter',
                style: TextStyle(fontSize: 16, color: Colors.black),
                
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
