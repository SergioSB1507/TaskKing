import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/Pages/marketPage.dart';
import 'package:practFire/Pages/profilePage.dart';
import 'package:practFire/Pages/tasksPage.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);

  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  final ProfilePage _profilePage = ProfilePage();

  int _globalIndex = 0;

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return TasksPage(user: widget.user);
        break;
      case 1:
        return MarketPage(user: widget.user);
        break;
      case 2:
        return _profilePage;
        break;
      default:
        return Container(
          child: Center(
            child: Text('No has seleccionado nada'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        items: <Widget>[
          Icon(Icons.assignment, size: 20, color: Colors.black),
          Icon(Icons.monetization_on, size: 20, color: Colors.black),
          Icon(Icons.account_circle, size: 20, color: Colors.black),
        ],
        color: Colors.white,
        backgroundColor: Colors.red,
        buttonBackgroundColor: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        height: 60,
        onTap: (int tappedIndex) {
          setState(() {
            _globalIndex = tappedIndex;
          });
        },
      ),
      body: Container(
        color: Colors.blueAccent,
        child: _pageChooser(_globalIndex),
      ),
    );
  }
}
