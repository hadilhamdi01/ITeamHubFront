import 'package:flutter/material.dart';
import 'package:frontend/AvatarScreen.dart';
import 'package:frontend/CentresInteretsScreen.dart';
import 'package:frontend/SelectCommunityPage.dart';
import 'package:frontend/addPost.dart';
import 'package:frontend/admin_screen.dart';
import 'package:frontend/pseudo.dart';
import 'package:frontend/reset_password_page.dart';
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
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/admin': (context) => AdminScreen(),
        '/password-reset': (context) => ResetPasswordPage(), 
        '/pseudo': (context) => PseudoScreen(), 
        '/centres_interets':(context) => CentresInteretsScreen(), 
        '/select':(context) => SelectCommunityPage(content: 'required String content, XFile? mediaFile',), 
        
      
        '/sexe': (context) => SexeScreen(),
        '/avatar': (context) => AvatarScreen(),

      },
    );
  }
}










