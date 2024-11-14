import 'package:flutter/material.dart';
import 'auth_service.dart';



class SexeScreen extends StatefulWidget {
  @override
  _SexeScreenState createState() => _SexeScreenState();
}

class _SexeScreenState extends State<SexeScreen> {
  final TextEditingController _sexeController = TextEditingController();

  void _goToCentresInteretsScreen(String email, String password, String pseudo) {
    Navigator.pushNamed(
      context,
      '/centres_interets',
      arguments: {
        'email': email,
        'password': password,
        'pseudo': pseudo,
        'sexe': _sexeController.text,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String email = args['email']!;
    final String password = args['password']!;
    final String pseudo = args['pseudo']!;
    
    return Scaffold(
      appBar: AppBar(title: Text('Sexe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _sexeController,
              decoration: InputDecoration(labelText: 'Sexe'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _goToCentresInteretsScreen(email, password, pseudo),
              child: Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
