import 'package:flutter/material.dart';
import 'package:frontend/addPost.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(userData: {}),  // User data empty initially, will be updated later
    );
  }
}

class HomePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  HomePage({required this.userData}); // Constructor to accept user data

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for the Scaffold

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPostPage()),
      );
    } else if (index == 4) {
      if (widget.userData.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfilePage(userData: widget.userData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Les données utilisateur ne sont pas disponibles.')),
        );
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text('Users Page')),
    Container(),
    Center(child: Text('Messages Page')),
    Center(child: Text('Notifications Page')), // Placeholding page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      key: _scaffoldKey, // Associate the key with the Scaffold
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: Text(
          'iTeamHub',
          style: TextStyle(color: const Color.fromARGB(255, 190, 56, 16),
           fontWeight: FontWeight.bold,  // Rendre le texte en gras
    fontSize: 20,),
        ),
        actions: [
          if (widget.userData.isNotEmpty && widget.userData['avatar'] != null)
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openEndDrawer(); // Open the Drawer when the avatar is tapped
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipOval(
                  child: Image.asset(
                    widget.userData['avatar'], // Utilisation de AssetImage pour l'avatar
                    width: 70, // Largeur de l'avatar
                    height: 70, // Hauteur de l'avatar
                    fit: BoxFit.contain, // L'image s'ajuste bien dans le cercle
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Communautés',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Créer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Discuter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
      // Drawer à gauche
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromARGB(255, 16, 16, 16),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.userData['avatar'] != null
                      ? Image.asset(
                          widget.userData['avatar'],
                          fit: BoxFit.contain,
                          width: 70,  
                          height: 70,
                        )
                      : Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                  SizedBox(width: 10),
                  Text(
                    widget.userData['pseudo'] ?? 'Utilisateur',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[700]),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('Mon Profil', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(userData: widget.userData),
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.grey[700]),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Paramètres', style: TextStyle(color: Colors.white)),
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[700]),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Se Déconnecter', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Drawer à droite (endDrawer) 
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromARGB(255, 16, 16, 16),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.userData['avatar'] != null
                      ? Image.asset(
                          widget.userData['avatar'],
                          fit: BoxFit.contain,
                          width: 240,  
                          height: 240,
                        )
                      : Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                ],
              ),
            ),
            Divider(color: Colors.grey[700]),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.white),
                    title: Text('Mon Profil', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfilePage(userData: widget.userData),
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.grey[700]),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text('Paramètres', style: TextStyle(color: Colors.white)),
                    onTap: () {},
                  ),
                  Divider(color: Colors.grey[700]),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Se Déconnecter', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
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

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: Center(
        child: Text(
          'Page d\'accueil',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;

  UserProfilePage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        title: Text('Profil de ${userData['pseudo']}'),
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      ),
      body: Center(
        child: Text(
          'Détails du profil',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class AddPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: Text('Ajouter un Post'),
      ),
      body: Center(
        child: Text(
          'Page pour ajouter un post',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
