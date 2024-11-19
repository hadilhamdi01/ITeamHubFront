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
            backgroundColor: const Color.fromARGB(255, 16, 16, 16),

      appBar: AppBar(  backgroundColor: const Color.fromARGB(255, 16, 16, 16)),
      body: SingleChildScrollView(
  child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image avec bords arrondis (sans cercle)
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Coins arrondis
              child: Image.asset(
                'assets/reddit_icon.png', // Chemin de l'image
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // "Saisis tes informations de connexion" Text
            Text(
              'Salut l\'ami.e, bienvenue sur iTeamHub',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 20),
            // Agreement Text
            Text(
              "En Créer un compte pour te lancer.",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
              textAlign: TextAlign.center,
            ),
              SizedBox(height: 30),
             TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
           SizedBox(height: 30),
            // Password Input Field
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
            ),
             SizedBox(height: 40),
            // Agreement Text
            Text(
              "En continuant, tu acceptes notre Contrat d'utilisation et confirmes que tu comprends notre Politique de confidentialité.",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Continue Button
            ElevatedButton(
              onPressed: _goToPseudoScreen,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 56, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: Text(
                'Suivant',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
           
          ],
        ),
      ),
      ),
    );
  }
}
