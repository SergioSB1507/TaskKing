import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/Pages/Setup/signIn.dart';
import 'package:practFire/widgets/welcomeButtons.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Stack(
          children: <Widget>[
            /*
            Image.asset(
              'assets/fond.jpg',
              fit: BoxFit.cover,
              width: 600,
              height: 2000,
            ),*/
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.white,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: Text(
                        'Register on KingTask',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Create a new account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 40, 30),
                    child: Material(
                      elevation: 5,
                      shape: StadiumBorder(),
                      color: Colors.white70,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please type an email';
                            }
                          },
                          //actualizamos el valor de _email
                          onSaved: (newValue) => _email = newValue,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 40, 30),
                    child: Material(
                      elevation: 5,
                      shape: StadiumBorder(),
                      color: Colors.white70,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          validator: (value) {
                            if (value.length < 6) {
                              return 'Introduce at least 6 characters';
                            }
                          },
                          //actualizamos el valor de _password
                          onSaved: (newValue) => _password = newValue,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: WelcomeButtons(text: 'Sign Up', method: signUp),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email.trim(), password: _password))
            .user;

        Firestore.instance
            .collection('Usuarios/${user.uid}/Tareas')
            .document()
            .setData({'name': 'Nueva Tarea ${user.email}'});
        Firestore.instance
            .collection('Usuarios/${user.uid}/Coins')
            .document()
            .setData({'money': 50});
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Crocodile',
          'price': 10,
          'image': 'assets/cocodrile.png',
          'added': false
        });
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Eagle',
          'price': 20,
          'image': 'assets/eagle.png',
          'added': false
        });
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Groot',
          'price': 10,
          'image': 'assets/groot.png',
          'added': false
        });
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Lion',
          'price': 10,
          'image': 'assets/lion.png',
          'added': false
        });
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Skull',
          'price': 10,
          'image': 'assets/skull.png',
          'added': false
        });
        Firestore.instance
            .collection('Usuarios/${user.uid}/Achievements')
            .document()
            .setData({
          'name': 'Wolf',
          'price': 10,
          'image': 'assets/wolf.png',
          'added': false
        });

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
