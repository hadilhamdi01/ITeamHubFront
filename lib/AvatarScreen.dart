import 'package:flutter/material.dart';
import 'package:frontend/auth_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AvatarScreen extends StatefulWidget {
  @override
  _AvatarScreenState createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8); // Ajout pour espacement
  final AuthService _authService = AuthService();

  String? _selectedAvatar;

  // Liste des avatars
  final List<String> avatars = [
    'assets/avatar1.jpg',
    'assets/avatar2.jpg',
    'assets/avatar3.jpg',
    'assets/avatar4.jpg',
    'assets/avatar5.jpg',
    'assets/avatar6.jpg',
  ];

  // Méthode pour enregistrer
  void _register(Map<String, dynamic> args) async {
    Navigator.pushReplacementNamed(context, '/login');

    if (_selectedAvatar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Veuillez sélectionner un avatar.')));
      return;

      
   
  
    }

  


    bool success = await _authService.registerUser(
      args['email'],
      args['password'],
      args['pseudo'],
      args['sexe'],
      _selectedAvatar!,
      args['centresInteret'],
    );
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inscription réussie !')));
      Navigator.popUntil(context, ModalRoute.withName('/'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'inscription')));
    }
  }

  // Méthodes pour changer les pages
  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_pageController.page! < avatars.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
     backgroundColor: const Color.fromRGBO(16, 16, 16, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      ),
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/reddit_icon.png',
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Avatar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
              Text(
            'Sélectionne ton premier avatar.\nTu pourras modifier le style plus tard.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
       
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: avatars.length,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedAvatar = avatars[index];
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAvatar = avatars[index];
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 250,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _selectedAvatar == avatars[index]
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              avatars[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: _previousPage,
                  ),
                ),
                Positioned(
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: _nextPage,
                  ),
                ),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: avatars.length,
            effect: WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),

            SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _register(args),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 190, 56, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: Text(
                  'Enregistrer',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
        
          
        ],
       ),),
    );
  }
}
