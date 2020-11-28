import 'package:flutter/material.dart';

class WelcomeButtons extends StatelessWidget {
  final String text;
  final dynamic method;

  const WelcomeButtons({@required this.text, this.method});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.blue, Colors.red[200]],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.2),
              offset: Offset(0, 8),
              blurRadius: 8,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: method, //Le pasamos el método a realizar
              child: Center(
                child: Text(
                  text, //Texto que se muestra en el boton
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
