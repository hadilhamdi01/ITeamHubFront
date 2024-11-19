import 'package:flutter/material.dart';

class SexeScreen extends StatefulWidget {
  @override
  _SexeScreenState createState() => _SexeScreenState();
}

class _SexeScreenState extends State<SexeScreen> {
  String? _selectedSexe;

  void _goToCentresInteretsScreen(String email, String password, String pseudo) {
    if (_selectedSexe != null) {
      Navigator.pushNamed(
        context,
        '/centres_interets',
        arguments: {
          'email': email,
          'password': password,
          'pseudo': pseudo,
          'sexe': _selectedSexe!,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une option.')),
      );
    }
  }

  Widget _buildSexeButton(String text, String value) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      onPressed: () {
        setState(() {
          _selectedSexe = value;
        });
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String email = args['email']!;
    final String password = args['password']!;
    final String pseudo = args['pseudo']!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 16, 16, 16)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Coins arrondis
                  child: Image.asset(
                    'assets/reddit_icon.png', // Chemin de l'image
                    height: 120,
                    width: 120, // Taille fixe
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'À propos de toi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Pour améliorer vos recommandations et vos publicités, parlez-nous de vous.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Comment est-ce que tu t’identifies ?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              _buildSexeButton('Homme', 'Homme'),
              SizedBox(height: 15),
              _buildSexeButton('Femme', 'Femme'),
              SizedBox(height: 15),
              _buildSexeButton('Non-binaire', 'Non-binaire'),
              SizedBox(height: 15),
              _buildSexeButton('Je préfère ne pas répondre', 'Je préfère ne pas répondre'),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _goToCentresInteretsScreen(email, password, pseudo),
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
