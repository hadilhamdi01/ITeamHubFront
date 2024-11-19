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
  final pseudo = _pseudoController.text.trim();

  if (pseudo.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Le pseudo ne peut pas être vide.')),
    );
    return;
  }

  if (pseudo.length < 3 || pseudo.length > 15) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Le pseudo doit comporter entre 3 et 15 caractères.')),
    );
    return;
  }

  final pseudoRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  if (!pseudoRegex.hasMatch(pseudo)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Le pseudo ne peut contenir que des lettres, chiffres et underscores (_).')),
    );
    return;
  }

  // Si toutes les conditions sont respectées, naviguer vers l'écran suivant
  Navigator.pushNamed(
    context,
    '/sexe',
    arguments: {
      'email': email,
      'password': password,
      'pseudo': pseudo,
    },
  );
}

  @override
  Widget build(BuildContext context) {
     final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String email = args['email']!;
    final String password = args['password']!;
     String? _errorText;
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),

      appBar: AppBar(  backgroundColor: const Color.fromARGB(255, 16, 16, 16)),
      body: SingleChildScrollView(
  child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
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
              'Créer ton pseudo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            
             SizedBox(height: 20),
            // Agreement Text
            Text(
              "En Choisis un nom à utiliser sur iTeamHub. Fais attention, tu ne pourras pas le modifier plus tard.",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
           TextField(
              controller: _pseudoController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Saisir pseudo',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
            
  onChanged: (value) {
    setState(() {
      if (value.isEmpty) {
        _errorText = 'Le pseudo ne peut pas être vide.';
      } else if (value.length < 3 || value.length > 15) {
        _errorText = 'Le pseudo doit comporter entre 3 et 15 caractères.';
      } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
        _errorText = 'Utilisez uniquement lettres, chiffres ou underscores (_).';
      } else {
        _errorText = null; // Pas d'erreur
      }
    });
  },
),
  SizedBox(height: 40),
            // Agreement Text
            Text(
              "En continuant, tu acceptes notre Contrat d'utilisation et confirmes que tu comprends notre Politique de confidentialité.",
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
              textAlign: TextAlign.center,
            ),
  SizedBox(height: 30),
             ElevatedButton(
              onPressed:  () => _goToSexeScreen(email, password),
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
