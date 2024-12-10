import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> userData;
    int _selectedIndex = 0;

  UserProfilePage({required this.userData});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${userData['email']}'),
            Text('Pseudo: ${userData['pseudo']}'),
            Text('Role: ${userData['role'].join(', ')}'),
            Text('Sexe: ${userData['sexe']}'),
            userData['avatar'] != null
                ? Image.network(userData['avatar'])
                : SizedBox(height: 100, child: Center(child: Text('No Avatar'))),
          ],
        ),
      ),
    );
  }
}
