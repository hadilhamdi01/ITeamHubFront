import 'package:flutter/material.dart';
import 'addPost.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPostPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text('Users Page')),
    Container(), // Placeholder pour Add, géré par Navigator
    Center(child: Text('Messages Page')),
    Center(child: Text('Profile Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 16, 16, 16),

      appBar: AppBar(
        backgroundColor:   const Color.fromARGB(255, 16, 16, 16),
   
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Affiche un champ de recherche dans une boîte de dialogue
              showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Home Page Content',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    String searchQuery = ''; // Variable pour stocker la recherche
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Recherche'),
          content: TextField(
            decoration: InputDecoration(hintText: 'Entrez un mot clé'),
            onChanged: (value) {
              searchQuery = value; // Met à jour la recherche
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme la boîte de dialogue
                // Affiche un message avec le terme recherché
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vous avez recherché : $searchQuery')),
                );
              },
              child: Text('Rechercher'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme la boîte de dialogue sans rechercher
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }
}
