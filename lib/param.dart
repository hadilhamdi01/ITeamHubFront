import 'package:flutter/material.dart';
import 'package:frontend/avatarEdit.dart';
import 'package:frontend/editPassword.dart';
import 'package:frontend/auth_service.dart';
import 'package:frontend/login_screen.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key, required this.userData}) : super(key: key);

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
   // const titleColor = Color.fromARGB(255, 132, 130, 130);
   const titleColor = Color.fromARGB(255, 254, 252, 252);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        title: const Text("Paramètres", style: TextStyle(color: titleColor)),
      ),
      body: ListView(
        children: [
          // Section: Général
          const SectionHeader(title: "GÉNÉRAL"),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              "Paramètres du compte - u/${userData['pseudo'] ?? 'Utilisateur'}",
              style: const TextStyle(color: Color.fromARGB(255, 254, 252, 252)),
            ),
            trailing: const Icon(Icons.arrow_forward),
           onTap: () async {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditPass(
        userData: userData,
        onLogout: () async {
          // Nettoyer les données de session
          final authService = AuthService();
          await authService.clearToken();
          
          // Rediriger vers la page de connexion
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        },
      ),
    ),
  );
},
          ),
          const Divider(),

          // Section: Premium
          const SectionHeader(title: "PREMIUM"),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: const Text("Passer Premium", style: TextStyle(color: titleColor)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.app_settings_alt),
            title: const Text("Changer l'icône de l'application", style: TextStyle(color: titleColor)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Personnaliser l'avatar", style: TextStyle(color: titleColor)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CustomizeAvatarScreen()),
    );
            },
          ),
          const Divider(),

          // Section: Langue
          const SectionHeader(title: "LANGUE"),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Langue", style: TextStyle(color: titleColor)),
            trailing: DropdownButton<String>(
              value: "Utiliser la langue de l'appareil",
              underline: Container(),
              items: const [
                DropdownMenuItem(
                  value: "Utiliser la langue de l'appareil",
                  child: Text("Utiliser la langue de l'appareil"),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text("Langues du contenu", style: TextStyle(color: titleColor)),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {},
          ),
          const Divider(),

          // Section: Options d'affichage
          const SectionHeader(title: "OPTIONS D'AFFICHAGE"),
          ListTile(
            leading: const Icon(Icons.view_compact),
            title: const Text("Vue par défaut", style: TextStyle(color: titleColor)),
            trailing: DropdownButton<String>(
              value: "Carte",
              underline: Container(),
              items: const [
                DropdownMenuItem(
                  value: "Carte",
                  child: Text("Carte"),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text("Vignettes", style: TextStyle(color: titleColor)),
            trailing: DropdownButton<String>(
              value: "Défaut de la communauté",
              underline: Container(),
              items: const [
                DropdownMenuItem(
                  value: "Défaut de la communauté",
                  child: Text("Défaut de la communauté"),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.visibility),
            title: const Text("Afficher le contenu sensible (j'ai plus de 18 ans)", style: TextStyle(color: titleColor)),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            secondary: const Icon(Icons.blur_on),
            title: const Text("Flouter les images et les médias sensibles (18+)", style: TextStyle(color: titleColor)),
            value: false,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
