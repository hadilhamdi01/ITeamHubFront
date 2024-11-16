import 'package:flutter/material.dart';
import 'package:frontend/auth_service.dart';

class AvatarScreen extends StatefulWidget {
  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final AuthService _authService = AuthService();
  String? _selectedAvatar; // Avatar sélectionné

  // Liste d'avatars
  final List<String> avatars = [
    'assets/avatar1.jpg',
 
    // Ajoutez d'autres chemins vers vos avatars ici
  ];

  // Méthode pour effectuer l'enregistrement
  void _register(Map<String, dynamic> args) async {
    if (_selectedAvatar == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez sélectionner un avatar.')));
      return;
    }

    bool success = await _authService.registerUser(
      args['email'],
      args['password'],
      args['pseudo'],
      args['sexe'],
      _selectedAvatar!, // Passe l'avatar sélectionné
      args['centresInteret'], // Passe les centres d'intérêt sélectionnés
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
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text('Choisissez un avatar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Sélectionnez un avatar :', style: TextStyle(fontSize: 18)),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final avatar = avatars[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = avatar;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _selectedAvatar == avatar ? Colors.blue : Colors.transparent,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(avatar, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _register(args),
              child: Text('Terminer l\'inscription'),
            ),
          ],
        ),
      ),
    );
  }
}
