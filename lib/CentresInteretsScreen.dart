import 'package:flutter/material.dart';

class CentresInteretsScreen extends StatefulWidget {
  @override
  _CentresInteretsScreenState createState() => _CentresInteretsScreenState();
}

class _CentresInteretsScreenState extends State<CentresInteretsScreen> {
  // Centres d'intérêt classés par catégorie
  final Map<String, List<Map<String, String>>> centresInteret = {
    ' 🔥 Trending': [
      {'id': '673c5a299fd7415af6492a50', 'nom': 'World news'},
      {'id': '673c5a299fd7415af6492a51', 'nom': 'World series'},
      {'id': '673c5a299fd7415af6492a52', 'nom': 'Halloween'},
      {'id': '673c5a299fd7415af6492a53', 'nom': 'Formula 1'},
      {'id': '673c595b9fd7415af6492a4f', 'nom': 'Open AI'},
    ],
    '😂 Humor & Memes': [
      {'id': '673c5a299fd7415af6492a54', 'nom': 'Funny videos'},
      {'id': '673c5a769fd7415af6492a55', 'nom': 'Memes'},
      {'id': '673c5a769fd7415af6492a56', 'nom': 'Funny animals'},
      {'id': '673c5a769fd7415af6492a58', 'nom': 'Stand-up comedy'},
      {'id': '673c5a769fd7415af6492a57', 'nom': 'Jokes'},
    ],
    '🎮 Gaming': [
      {'id': '673c5a769fd7415af6492a59', 'nom': 'Gaming news'},
      {'id': '673c5adf9fd7415af6492a5a', 'nom': 'Xbox'},
      {'id': '673c5adf9fd7415af6492a5c', 'nom': 'League of Legends'},
      {'id': '673c5adf9fd7415af6492a5b', 'nom': 'PlayStation'},
      {'id': '673c5adf9fd7415af6492a5d', 'nom': 'Valorant'},
    ],
    '📚🔬 Learning & Science': [
      {'id': '673c5adf9fd7415af6492a5e', 'nom': 'Ask Science'},
      {'id': '673c5b2a9fd7415af6492a5f', 'nom': 'Space'},
      {'id': '673c5b2a9fd7415af6492a62', 'nom': 'Computer Science'},
      {'id': '673c5b2a9fd7415af6492a60', 'nom': 'Nature'},
      {'id': '673c5b2a9fd7415af6492a61', 'nom': 'Interesting'},
    ],
    '📺 Television': [
      {'id': '673c5b2a9fd7415af6492a63', 'nom': 'Netflix'},
      {'id': '673c5b9a9fd7415af6492a64', 'nom': 'Disney+'},
      {'id': '673c5b9a9fd7415af6492a65', 'nom': 'Apple TV+'},
      {'id': '673c5b9a9fd7415af6492a66', 'nom': 'The Witcher'},
      {'id': '673c5b9a9fd7415af6492a67', 'nom': 'Star Wars'},
    ],
    '🎌 Anime & Manga': [
      {'id': '673c5b9a9fd7415af6492a68', 'nom': 'Anime memes'},
      {'id': '673c5bf59fd7415af6492a69', 'nom': 'Manga'},
      {'id': '673c5bf59fd7415af6492a6a', 'nom': 'Naruto'},
      {'id': '673c5bf59fd7415af6492a6b', 'nom': 'One Piece'},
      {'id': '673c5bf59fd7415af6492a6c', 'nom': 'Cosplayers'},
    ],
  };

  // IDs des centres d'intérêt sélectionnés
  List<String> selectedCentresInteret = [];

  @override
  Widget build(BuildContext context) {
    // Vérifiez si les arguments sont passés et valides
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Erreur")),
        body: Center(child: Text("Aucun argument fourni")),
      );
    }

    // Récupération des arguments
    final String email = args['email'] ?? 'Email inconnu';
    final String password = args['password'] ?? 'Mot de passe inconnu';
    final String pseudo = args['pseudo'] ?? 'Pseudo inconnu';
    final String sexe = args['sexe'] ?? 'Sexe inconnu';

    return Scaffold(
      backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/reddit_icon.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Centres d\'intérêt',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Choisissez ce que vous aimeriez voir dans ton flux d\'accueil.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: centresInteret.entries.map((entry) {
                  final String category = entry.key;
                  final List<Map<String, String>> items = entry.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: items.map((centre) {
                          final bool isSelected = selectedCentresInteret.contains(centre['id']);
                          Color backgroundColor = Colors.grey.shade200;

                          // Change background color for specific categories
                          if (category == ' 🔥 Trending' || category == '🎌 Anime & Manga') {
                            backgroundColor = Colors.white;
                          }

                          return ChoiceChip(
                            label: Text(centre['nom']!),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  selectedCentresInteret.add(centre['id']!);
                                } else {
                                  selectedCentresInteret.remove(centre['id']!);
                                }
                              });
                            },
                            selectedColor: const Color.fromARGB(255, 190, 56, 16),
                            backgroundColor: backgroundColor,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Coins arrondis
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }).toList(),
              ),
            ),



             SizedBox(height: 30),
              ElevatedButton(
             onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/avatar',
                    arguments: {
                      'email': email,
                      'password': password,
                      'pseudo': pseudo,
                      'sexe': sexe,
                      'centresInteret': selectedCentresInteret,
                    },
                  );
                },
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
    );
  }
}
