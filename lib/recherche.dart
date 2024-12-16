import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/home_screen.dart';
import 'package:http/http.dart' as http;

class SearchUserScreen extends StatefulWidget {
  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  final TextEditingController _pseudoController = TextEditingController();
  List<dynamic> users = []; // Liste des utilisateurs trouvés
  String? errorMessage;

  // Liste statique pour les tendances
  final List<Map<String, String>> trends = [
    {
      "title": "NBA Cup semifinals",
      "subtitle": "Doc Rivers Notes Change in Young: Earned Hawks' Trust",
      "image": "assets/img1.jpg"
    },
    {
      "title": "Billie Eilish hit by object",
      "subtitle": "Billie Eilish was hit by an object during a show",
      "image": "assets/img2.jpg"
    },
    {
      "title": "UFC Saudi Arabia card",
      "subtitle": "Just got announced. What do we think?",
      "image": "assets/img3.jpg"
    },
     {
      "title": "South Korea impeaches Yoon",
      "subtitle": "South Korea's president impeached by parliament after mass protests over short-il...",
      "image": "assets/img4.jpg"
    },
     {
      "title": "Saturday Night's Main Event",
      "subtitle": "Card for Saturday Nights Main Event on NBC -12.14",
      "image": "assets/img5.jpg"
    },
  ];

  // Fonction pour rechercher des utilisateurs
  Future<void> searchUser(String pseudo) async {
    final url = Uri.parse('http://192.168.149.50:3000/users/search?pseudo=$pseudo');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          users = [data]; // Stocker le résultat dans une liste
          errorMessage = null;
        });
      } else {
        setState(() {
          users = [];
          errorMessage = 'Utilisateur non trouvé.';
        });
      }
    } catch (e) {
      setState(() {
        users = [];
        errorMessage = 'Erreur : $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recherche Utilisateur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barre de recherche avec loupe
            TextField(
              controller: _pseudoController,
              decoration: InputDecoration(
                labelText: 'Rechercher sur iTeamHub',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              onSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  searchUser(value.trim());
                }
              },
            ),
            SizedBox(height: 16.0),
            // Résultats de la recherche
            Expanded(
              child: ListView(
                children: [
                  if (users.isNotEmpty) ...[
                    // Afficher les résultats sans Card
                    ...users.map((user) => ListTile(
                      title: Text(
                        user['pseudo'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(user['email'] ?? ''),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(user: user),
                          ),
                        );
                      },
                    )),
                    Divider(),
                  ],
                  // Message d'erreur
                  if (errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: Colors.red.shade100,
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Divider(),
                  ],
                  // Bloc "Tendances du jour"
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      "Tendances du jour",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // ListView pour afficher les tendances
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // Désactive le scroll interne
                    itemCount: trends.length,
                    separatorBuilder: (context, index) => Divider(
                      thickness: 0.8,
                      color: Colors.grey[300],
                    ),
                    itemBuilder: (context, index) {
                      final trend = trends[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image à gauche
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                trend['image']!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10), // Espacement entre image et texte
                            // Colonne pour le titre et sous-titre
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    trend['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(height: 3), // Espacement
                                  Text(
                                    trend['subtitle']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Écran pour afficher les détails de l'utilisateur
class UserDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Partie supérieure avec un dégradé radial autour de l'avatar
          Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 0.0, bottom: 50.0),
            child: Stack(
              children: [
                // Le dégradé radial de fond
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Color(0xFF1e3c72), // Bleu plus foncé
                        Color(0xFF2a5298), // Bleu plus clair
                        Colors.black, // Noir
                      ],
                      center: Alignment.topCenter,
                      radius: 1.0,
                    ),
                  ),
                ),
                // Contenu dans la partie supérieure
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 150.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: user['avatar'] != null
                            ? ClipOval(
                                child: Image.asset(
                                  user['avatar'],
                                  fit: BoxFit.contain,
                                  width: 110,
                                  height: 110,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                // Les icônes en haut à droite (loupe et flèche de partage)
                Positioned(
                  top: 20,
                  right: 20,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          print('Recherche');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          print('Partager');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Colonne pour afficher le pseudo et l'e-mail
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
                    Text(
                      '${user['pseudo']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${user['email']}',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                 // Boutons pour "Ajouter en ami" et "Envoyer un message"
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Ajouter en ami'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Message'),
                    ),
                  ],
                ),
              

               
              ],
            ),
          ),
          // Partie inférieure avec une autre couleur de fond
          SizedBox(height: 12),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 16, 16, 16),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.blueAccent,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white60,
                      indicatorWeight: 3,
                      tabs: [
                        Tab(text: "Publications"),
                        Tab(text: "Commentaires"),
                        Tab(text: "À propos"),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: Text(
                              "Aucune publication",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Aucun commentaire",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Informations à propos",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}