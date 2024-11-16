import 'package:flutter/material.dart';
import 'package:frontend/auth_service.dart';

class CentresInteretsScreen extends StatefulWidget {
  @override
  _CentresInteretsScreenState createState() => _CentresInteretsScreenState();
}

class _CentresInteretsScreenState extends State<CentresInteretsScreen> {
  final AuthService _authService = AuthService();
  // Liste de centres d'intérêt prédéfinis (que l'utilisateur peut sélectionner)
  List<Map<String, String>> centresInteret = [
    {'id': '6735b9b0a9cdc27f176a5920', 'nom': 'Musique'},
    {'id': '2', 'nom': 'Sports'},
    {'id': '3', 'nom': 'Voyages'},
    {'id': '4', 'nom': 'Technologie'},
    {'id': '5', 'nom': 'Lecture'},
    // Ajoutez ici d'autres centres d'intérêt
  ];

  List<String> selectedCentresInteret = []; // Stocke les IDs sélectionnés

  // Inscription avec les centres d'intérêt sélectionnés
  void _register(String email, String password, String pseudo, String sexe) async {
    bool success = await _authService.registerUser(
      email,
      password,
      pseudo,
      sexe,
      selectedCentresInteret, // Envoie les IDs sélectionnés
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Inscription réussie !')));
      Navigator.popUntil(context, ModalRoute.withName('/')); // Retour à la page d'accueil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de l\'inscription')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String email = args['email']!;
    final String password = args['password']!;
    final String pseudo = args['pseudo']!;
    final String sexe = args['sexe']!;

    return Scaffold(
      appBar: AppBar(title: Text('Centres d\'intérêts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sélectionnez vos centres d\'intérêts :'),
            Expanded(
              child: ListView(
                children: centresInteret.map((centre) {
                  return CheckboxListTile(
                    title: Text(centre['nom']!),
                    value: selectedCentresInteret.contains(centre['id']),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCentresInteret.add(centre['id']!); // Ajoute l'ID
                        } else {
                          selectedCentresInteret.remove(centre['id']!); // Supprime l'ID
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _register(email, password, pseudo, sexe),
              child: Text('Terminer l\'inscription'),
            ),
          ],
        ),
      ),
    );
  }
}
