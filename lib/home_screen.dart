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
      key: _scaffoldKey, // Associate the key with the Scaffold
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: Text(
          'Accueil',
          style: TextStyle(color: Colors.white),
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
            fit: BoxFit.cover, // L'image s'ajuste bien dans le cercle
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
      endDrawer: Drawer( // Using endDrawer to open it on the right
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.userData['pseudo'] ?? 'Utilisateur'),
              accountEmail: Text(widget.userData['email'] ?? 'Email'),
              currentAccountPicture: widget.userData['avatar'] != null
                  ? CircleAvatar(
                      backgroundImage: AssetImage(widget.userData['avatar']),
                    )
                  : CircleAvatar(
                      child: Icon(Icons.person),
                    ),
            ),
            ListTile(
              title: Text('Mon Profil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(userData: widget.userData),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Paramètres'),
              onTap: () {
                // Add functionality for Settings here
              },
            ),
            ListTile(
              title: Text('Se Déconnecter'),
              onTap: () {
                // Add logout functionality here
              },
              
            ),
            IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Log out logic
              Navigator.pushReplacementNamed(context, '/login');
            },
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
      appBar: AppBar(
        title: Text('Profil utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${userData['email']}'),
            Text('Pseudo: ${userData['pseudo']}'),
            Text('Rôle: ${userData['role'].join(', ')}'),
            Text('Sexe: ${userData['sexe']}'),
            SizedBox(height: 16),
            userData['avatar'] != null
                ? Image.network(userData['avatar'])
                : SizedBox(height: 100, child: Center(child: Text('Aucun avatar'))),
          ],
        ),
      ),
    );
  }
}
