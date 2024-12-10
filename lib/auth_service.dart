import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
 static const String apiUrl = 'http://192.168.149.50:3000';
 static const String _meUrl = '$apiUrl/auth/me';
 final _storage = FlutterSecureStorage();


Future<bool> registerUser(
  String email,
  String password,
  String pseudo,
  String sexe,
  String avatar,
  List<String> centresInteretIds,
) async {
  final url = Uri.parse('$apiUrl/register');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'email': email,
      'password': password,
      'pseudo': pseudo,
      'sexe': sexe,
      'avatar': avatar,
      'centresInteret': centresInteretIds,
    }),
  );

  // Affiche la réponse de l'API pour le debug
  print('Réponse de l\'API : ${response.body}');

  if (response.statusCode == 201) {
    print('Utilisateur enregistré avec succès');
    return true;
  } else {
    print('Erreur lors de l\'inscription: ${response.body}');
    return false;
  }
}



Future<List<dynamic>> fetchCentresInteret() async {
  try {
    final url = Uri.parse('$apiUrl/api/centres_interet');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse and return the list of centres d'intérêt
      final List<dynamic> centresInteret = json.decode(response.body);
      print('Centres d\'intérêt récupérés avec succès: $centresInteret');
      return centresInteret;
    } else {
      print('Erreur lors de la récupération des centres d\'intérêt: ${response.body}');
      return [];
    }
  } catch (error) {
    print('Erreur réseau : $error');
    return [];
  }


  
}



 







  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


  
Future<bool> resetPassword(String email) async {
  final response = await http.post(
    Uri.parse('$apiUrl/forgot-password'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email}),
  );

  return response.statusCode == 200;
}


  Future<bool> sendPasswordResetEmail(String email) async {
    final url = Uri.parse('$apiUrl/password-reset');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    return response.statusCode == 200;
  }



  static Future<List<dynamic>> getCommunities() async {
    final response = await http.get(Uri.parse('$apiUrl/communities'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des communautés.');
    }
  }
  static Future<void> addPost(String content, String communityId, String? filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/posts'));
    request.fields['content'] = content;
    request.fields['communityId'] = communityId;

    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('media', filePath));
    }

    final response = await request.send();
    if (response.statusCode != 201) {
      throw Exception('Erreur lors de l\'ajout du post.');
    }
  }

}

