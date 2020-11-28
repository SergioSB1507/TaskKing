import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/Pages/home.dart';
import 'package:practFire/widgets/welcomeButtons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        'Sign in on KingTask',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Introduce your email and password',
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
                    child: WelcomeButtons(text: 'Sign In', method: signIn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _email.trim(), password: _password))
            .user;

        //Si el usuario es correcto, navegamos a la ventana de Home
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
