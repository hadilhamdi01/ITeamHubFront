import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendResetPasswordRequest() async {
    final String email = _emailController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.15:3000/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: '{"email": "$email"}',
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Un email a été envoyé avec succès.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${response.body}')),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion au serveur.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),

      appBar: AppBar(  backgroundColor: const Color.fromARGB(255, 16, 16, 16)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              'Réinitialiser ton mot de passe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 20),
            Text(
              'Entrez votre adresse e-mail valide..',
              style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 81, 80, 80)),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _emailController,
               style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
               
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30),
           SizedBox(
            width: 200, // Largeur spécifique du bouton
  height: 50,
  child: ElevatedButton(
    onPressed: _isLoading ? null : _sendResetPasswordRequest,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 190, 56, 16), // Couleur de fond du bouton
      foregroundColor: Colors.white,  // Couleur du texte
      padding: EdgeInsets.symmetric(vertical: 16.0), // Taille du bouton
    ),
    child: _isLoading
        ? CircularProgressIndicator(color: Colors.white)
        : Text('Envoyer'),
  ),
),

          ],
        ),
      ),
    );
  }
}