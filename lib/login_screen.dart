import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/auth_service.dart';
import 'package:frontend/home_screen.dart';
import 'package:frontend/user_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';
  String token = '';
    bool _isLoading = false;

Future<void> login() async {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // Requête pour se connecter
    final response = await http.post(
      Uri.parse('http://192.168.149.50:3000/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        token = data['token'];
      });
      // Sauvegarder le token dans un stockage sécurisé ou l'usage temporaire
      fetchUserData();
    } else {
      setState(() {
        errorMessage = 'Email ou mot de passe incorrect';
      });
    }
  }

  Future<void> fetchUserData() async {
    final response = await http.get(
      Uri.parse('http://192.168.149.50:3000/auth/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userData: userData),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Impossible de récupérer les informations de l\'utilisateur';
      });
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
            child: Text("S'inscrire", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/reddit_icon.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Connexion',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Saisir email ou pseudo',
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Saisir mot de passe',
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/password-reset');
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 190, 56, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: 
                     Text(
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
