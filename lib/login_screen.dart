import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // Récupérer les rôles de l'utilisateur depuis SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final roles = prefs.getStringList('roles') ?? [];

    // Vérifier les rôles et rediriger vers la bonne page
    if (roles.contains('admin')) {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Échec de la connexion. Veuillez réessayer.')),
    );
  }
}

  void _resetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez saisir votre adresse email.')),
      );
      return;
    }

    final success = await _authService.resetPassword(email);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Un email avec un nouveau mot de passe a été envoyé.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la réinitialisation du mot de passe.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
       appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      
        actions: [
          TextButton(
            onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
            child: Text("S\'inscrire", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body:SingleChildScrollView(
  child: Padding(
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
            SizedBox(height: 30),
            // "Saisis tes informations de connexion" Text
            Text(
              'Connexion',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Email Input Field
            TextField(
              controller: _emailController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Saisir email ou pseudo',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Password Input Field
            TextField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Saisir mot de passe',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // "Mot de passe oubliée?" link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/password-reset');
                },
                child: Text(
                  'Mot de passe oubliée ?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Agreement Text
            Text(
              "En continuant, tu acceptes notre Contrat d'utilisation et confirmes que tu comprends notre Politique de confidentialité.",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Continue Button
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 56, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: Text(
                'Se connecter',
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
