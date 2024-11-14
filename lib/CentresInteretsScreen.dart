import 'package:flutter/material.dart';
import 'package:frontend/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CentresInteretsScreen extends StatefulWidget {
  @override
  _CentresInteretsScreenState createState() => _CentresInteretsScreenState();
}

class _CentresInteretsScreenState extends State<CentresInteretsScreen> {
  final AuthService _authService = AuthService();
  List<dynamic> centresInteret = [];
  List<String> selectedCentresInteret = []; // Stocke les IDs sélectionnés

  @override
  void initState() {
    super.initState();
    fetchCentresInteret();
  }

  // Récupère les centres d'intérêt depuis l'API
  Future<void> fetchCentresInteret() async {
  final response = await http.get(Uri.parse('http://localhost:3000/api/centres_interet'));

  if (response.statusCode == 200) {
    print('Réponse de l\'API (centres d\'intérêts) : ${response.body}'); // Debug
    setState(() {
      centresInteret = json.decode(response.body);
    });
  } else {
    print('Erreur lors du chargement des centres d\'intérêt : ${response.statusCode}');
    throw Exception('Erreur lors du chargement des centres d\'intérêt');
  }
}


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
                    title: Text(centre['nom']),
                    value: selectedCentresInteret.contains(centre['id']),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCentresInteret.add(centre['id'].toString()); // Ajoute l'ID
                        } else {
                          selectedCentresInteret.remove(centre['id'].toString()); // Supprime l'ID
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
              child: Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}
