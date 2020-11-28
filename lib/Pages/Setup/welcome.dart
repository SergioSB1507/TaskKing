import 'package:flutter/material.dart';
import 'package:practFire/Pages/Setup/signIn.dart';
import 'package:practFire/Pages/Setup/signUp.dart';
import 'package:practFire/widgets/welcomeButtons.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.red],
            ),
          ),
          child: Stack(
            children: <Widget>[
              /*Image.asset(
                'assets/fond.jpg',
                fit: BoxFit.cover,
                width: 600,
                height: 2000,
              ),*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 300),
                      child: Center(
                        child: Text(
                          'KingTask',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Sign in or create a new account on KingTask!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    WelcomeButtons(text: 'SIGN IN', method: navigateToSignIn),
                    WelcomeButtons(text: 'SIGN UP', method: navigateToSignUp),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage(), fullscreenDialog: true));
  }
}
