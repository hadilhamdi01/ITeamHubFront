import 'package:flutter/material.dart';

class CentresInteretsScreen extends StatefulWidget {
  @override
  _CentresInteretsScreenState createState() => _CentresInteretsScreenState();
}

class _CentresInteretsScreenState extends State<CentresInteretsScreen> {
  // Liste de centres d'intérêt prédéfinis
  final List<Map<String, String>> centresInteret = [
    {'id': '6735b9b0a9cdc27f176a5920', 'nom': 'Musique'},
    {'id': '2', 'nom': 'Sports'},
    {'id': '3', 'nom': 'Voyages'},
    {'id': '4', 'nom': 'Technologie'},
    {'id': '5', 'nom': 'Lecture'},
    // Ajoutez d'autres centres d'intérêt ici si nécessaire
  ];

  // Stocke les IDs des centres d'intérêt sélectionnés
  List<String> selectedCentresInteret = [];

  @override
  Widget build(BuildContext context) {
    // Récupération des arguments passés à cette page
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
            Text(
              'Sélectionnez vos centres d\'intérêts :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: centresInteret.map((centre) {
                  return CheckboxListTile(
                    title: Text(centre['nom']!),
                    value: selectedCentresInteret.contains(centre['id']),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCentresInteret.add(centre['id']!);
                        } else {
                          selectedCentresInteret.remove(centre['id']!);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirection vers la page AvatarScreen
                Navigator.pushNamed(
                  context,
                  '/avatar', // Route de la page AvatarScreen
                  arguments: {
                    'email': email,
                    'password': password,
                    'pseudo': pseudo,
                    'sexe': sexe,
                    'centresInteret': selectedCentresInteret, // Passe les centres d'intérêt sélectionnés
                  },
                );
              },
              child: Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
