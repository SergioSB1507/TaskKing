import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/widgets/welcomeButtons.dart';

class NewTaskPage extends StatefulWidget {
  final FirebaseUser user;

  const NewTaskPage({Key key, this.user}) : super(key: key);

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 80, top: 30, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                    ),
                    Center(
                      child: Text(
                        'Create New Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                child: Material(
                  elevation: 5,
                  shape: StadiumBorder(),
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: TextField(
                      cursorColor: Colors.blue,
                      //actualizamos el valor del nombre
                      onSubmitted: (value) {
                        _name = value;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Material(
                  elevation: 5,
                  shape: StadiumBorder(),
                  color: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: TextFormField(
                      cursorColor: Colors.blue,

                      //actualizamos el valor de _password
                      onSaved: (newValue) {},
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: WelcomeButtons(
                  text: 'Create Task',
                  method: createTask,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createTask() {
    Firestore.instance
        .collection('Usuarios/${widget.user.uid}/Tareas')
        .document()
        .setData({'name': _name});
    Navigator.of(context).pop();
  }
}
