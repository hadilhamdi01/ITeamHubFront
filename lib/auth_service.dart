import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String apiUrl = 'http://localhost:3000';

Future<bool> registerUser(
    String email,
    String password,
    String pseudo,
    String sexe,
    List<String> centresInteretIds,
  ) async {
    print('Centres d\'intérêt sélectionnés : $centresInteretIds'); // Debug
    final url = Uri.parse('$apiUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'pseudo': pseudo,
        'sexe': sexe,
        'centresInteret': centresInteretIds,
      }),
    );

    if (response.statusCode == 201) {
      print('Utilisateur enregistré avec succès');
      return true;
    } else {
      print('Erreur lors de l\'enregistrement: ${response.body}');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('$apiUrl/reset-password'),
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
