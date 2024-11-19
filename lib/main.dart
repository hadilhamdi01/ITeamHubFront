import 'package:flutter/material.dart';
import 'package:frontend/AvatarScreen.dart';
import 'package:frontend/CentresInteretsScreen.dart';
import 'package:frontend/PasswordResetScreen.dart';
import 'package:frontend/admin_screen.dart';
import 'package:frontend/pseudo.dart';
import 'package:frontend/sexe.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/admin': (context) => AdminScreen(),
        '/password-reset': (context) => PasswordResetScreen(), 
        '/pseudo': (context) => PseudoScreen(), 
        '/centres_interets':(context) => CentresInteretsScreen(), 
        '/sexe': (context) => SexeScreen(),
        '/avatar': (context) => AvatarScreen(),

      },
    );
  }
}
