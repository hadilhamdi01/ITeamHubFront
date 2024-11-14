import 'package:flutter/material.dart';
import 'auth_service.dart';

class PseudoScreen extends StatefulWidget {
  const PseudoScreen({super.key});

  @override
  _PseudoScreenState createState() => _PseudoScreenState();
}

class _PseudoScreenState extends State<PseudoScreen> {

final TextEditingController _pseudoController = TextEditingController(); 

  final AuthService _authService = AuthService();

    void _goToSexeScreen(String email, String password) {
    Navigator.pushNamed(
      context,
      '/sexe',
      arguments: {
        'email': email,
        'password': password,
        'pseudo': _pseudoController.text,
      },
    );
  }
  @override
  Widget build(BuildContext context) {
     final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String email = args['email']!;
    final String password = args['password']!;
    
    return Scaffold(
      appBar: AppBar(title: Text('inscr')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
      
            SizedBox(height: 20),
            TextField(
              controller: _pseudoController,
              decoration: InputDecoration(
                hintText: 'Saisir pseudo',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
            onPressed: () => _goToSexeScreen(email, password),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
