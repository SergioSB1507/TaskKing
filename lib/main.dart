import 'package:flutter/material.dart';
import 'package:practFire/Pages/Setup/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KingTask',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: WelcomePage(),
    );
  }
}
