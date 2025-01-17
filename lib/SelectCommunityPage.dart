import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class SelectCommunityPage extends StatefulWidget {
  final String content;
  final XFile? mediaFile;

  SelectCommunityPage({required this.content, this.mediaFile});

  @override
  _SelectCommunityPageState createState() => _SelectCommunityPageState();
}

class _SelectCommunityPageState extends State<SelectCommunityPage> {
  String? selectedCommunity;
  List<dynamic> _communities = [];
  List<dynamic> _filteredCommunities = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCommunities();

    // Écouteur pour le champ de recherche
    searchController.addListener(() {
      filterCommunities();
    });
  }

  Future<void> _fetchCommunities() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.14.50:3000/api/communities'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          _communities = data.map<String>((community) {
            return community['name'] as String;
          }).toList();
          _filteredCommunities = _communities; // Initialise avec toutes les communautés
        });
      } else {
        throw Exception('Failed to load communities');
      }
    } catch (e) {
      print('Erreur: $e');
    }
  }

  void filterCommunities() {
    final query = searchController.text.toLowerCase();
    setState(() {
      _filteredCommunities = _communities.where((community) {
        return community.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> submitPost() async {
    if (selectedCommunity == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une communauté.')),
      );
      return;
    }

    // Ajouter ici votre logique d’envoi au backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post ajouté avec succès!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 16, 16, 16),

      appBar: AppBar(  backgroundColor: const Color.fromARGB(255, 16, 16, 16)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barre de recherche
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher une communauté',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            // DropdownButton pour les communautés
          

            Spacer(),
            SizedBox(height: 30),
             ElevatedButton(
              onPressed: submitPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 56, 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              ),
              child: Text(
                'Publier',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

           
          ],
        ),
      ),
    );
  }
}
