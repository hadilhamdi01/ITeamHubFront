import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String apiUrl = 'http://192.168.1.15:3000';

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



 Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];

      // Décoder le token pour récupérer les rôles
      final decodedToken = _decodeJwt(token);
      final roles = decodedToken['roles'];

      // Sauvegarder le token et les rôles dans SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setStringList('roles', List<String>.from(roles));

      return true;
    } else {
      return false;
    }
  }
Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    final payload = base64Url.decode(base64Url.normalize(parts[1]));
    return jsonDecode(utf8.decode(payload));
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
}