import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.red])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Center(
              child: Text(
                'Usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
