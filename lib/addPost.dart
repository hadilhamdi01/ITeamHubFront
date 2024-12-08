import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final TextEditingController contentController = TextEditingController();
  XFile? mediaFile;

  Future<void> pickMedia() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      mediaFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/select');
            },
            child: Text("Suivant", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Place le bouton en bas
          children: [
            // Zone d'écriture
            TextField(
              maxLines: null, // Permet un nombre illimité de lignes pour écrire
              cursorColor: Colors.blue, // Couleur du curseur
              cursorWidth: 2.0, // Épaisseur du curseur
              cursorRadius: Radius.circular(2.0), // Arrondi du curseur
              style: TextStyle(
                fontSize: 18.0, // Taille du texte
                color: Colors.white, // Couleur du texte
              ),
              decoration: InputDecoration(
                hintText: 'Commencez à écrire...', // Texte indicatif
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 252, 252, 252), // Couleur du texte indicatif
                  fontStyle: FontStyle.italic,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20.0, // Ajoute de l'espace vertical
                  horizontal: 16.0, // Ajoute de l'espace horizontal
                ),
                border: InputBorder.none, // Aucune bordure
              ),
              onChanged: (value) {
                // Gérer les changements de texte
                print("Texte entré : $value");
              },
            ),

            // Texte affichant le fichier sélectionné
            if (mediaFile != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Fichier sélectionné: ${mediaFile!.name}',
                  style: TextStyle(color: Colors.white),
                ),
              ),

            // Bouton placé en bas
          ElevatedButton(
  onPressed: pickMedia,
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Couleur de fond transparente
    shadowColor: Colors.transparent, // Supprime l'ombre
    padding: EdgeInsets.all(8), // Espacement interne
    shape: RoundedRectangleBorder( // Supprime la bordure arrondie
      borderRadius: BorderRadius.circular(0),
    ),
  ),
  child: Row(
    mainAxisSize: MainAxisSize.min, // S'ajuste à la taille minimale requise
    children: [
      Icon(Icons.attach_file, color: const Color.fromARGB(255, 190, 56, 16),), // Icône pour pièce jointe
      SizedBox(width: 10), // Espacement entre les icônes
      Icon(Icons.videocam, color: const Color.fromARGB(255, 190, 56, 16),), 
      SizedBox(width: 10), // Espacement entre les icônes
      Icon(Icons.photo, color: const Color.fromARGB(255, 190, 56, 16),),
    ],
  ),
),


          ],
        ),
      ),
    );
  }
}
