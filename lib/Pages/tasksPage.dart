import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/Pages/TaskPage/newTaskPage.dart';

class TasksPage extends StatelessWidget {
  final FirebaseUser user;
  const TasksPage({Key key, @required this.user}) : super(key: key);

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
          //alignment: Alignment.center,
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
              padding: const EdgeInsets.only(bottom: 560),
              child: Center(
                child: Text(
                  'Tasks',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: DraggableScrollableSheet(
                maxChildSize: 0.85,
                builder: (context, scrollController) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('Usuarios/${user.uid}/Tareas')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                DocumentSnapshot ds =
                                    snapshot.data.documents[index];
                                return ListTile(
                                  //DELETE SELECTED TASKS OF THE LIST
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                        title: Text('Delete task'),
                                        content: Text(
                                            'Do you want to delete the tast permanently?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              Firestore.instance
                                                  .collection(
                                                      'Usuarios/${user.uid}/Tareas')
                                                  .document(snapshot
                                                      .data
                                                      .documents[index]
                                                      .documentID)
                                                  .delete();
                                              Navigator.of(context).pop('Ok');
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop('Cancel');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  title: Text(
                                    ds['name'],
                                    style: TextStyle(
                                        color: Colors.grey[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'Detalles de la tarea ${ds['name']}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.check_circle,
                                    color: Colors.greenAccent,
                                  ),
                                  isThreeLine: true,
                                );
                              },
                              controller: scrollController,
                              itemCount: snapshot.data.documents.length,
                            );
                          },
                        ),
                      ),
                      Positioned(
                        child: FloatingActionButton(
                          child: Icon(Icons.add, color: Colors.white),
                          //ADD NEW TASK

                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewTaskPage(user: user),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          backgroundColor: Colors.redAccent,
                        ),
                        height: 40,
                        top: 5,
                        right: 40,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
