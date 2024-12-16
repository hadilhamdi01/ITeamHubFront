import 'package:flutter/material.dart';
import 'package:frontend/modifier.dart'; // Assurez-vous que ce fichier existe et que vous avez la page UpdateProfilePage

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserProfilePage({required this.userData});

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
                        Colors.black,      // Noir
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
                        child: userData['avatar'] != null
                            ? ClipOval(
                                child: Image.asset(
                                  userData['avatar'],
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
                      // Loupe
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: () {
                          // Action pour la loupe (par exemple, ouvrir une page de recherche)
                          print('Recherche');
                        },
                      ),
                      // Flèche de partage
                      IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          // Action pour le partage
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
                      '${userData['pseudo']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                  ],
                ),
                // Bouton "Modifier" aligné à droite et légèrement plus haut
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent, // Fond transparent
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                    elevation: 8,
                  ),
                  onPressed: () {
                    // Naviguer vers la page UpdateProfileUser
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfilePage(userData: userData),
                      ),
                    );
                  },
                  child: Text(
                    "Modifier",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
