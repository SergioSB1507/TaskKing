import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practFire/widgets/shopItemDetail.dart';

/*MediaQuery.of(context).size.width - 10*/

class MarketPage extends StatefulWidget {
  final FirebaseUser user;

  const MarketPage({Key key, @required this.user}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Text(
                      'Shop',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('Usuarios/${widget.user.uid}/Coins')
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
                DocumentSnapshot ds = snapshot.data.documents[0];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text(
                        'Coins: ${ds['money']}',
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      shape: StadiumBorder(),
                      onPressed: () {
                        Firestore.instance
                            .collection('Usuarios/${widget.user.uid}/Coins')
                            .document(snapshot.data.documents[0].documentID)
                            .updateData({'money': ds['money'] + 5});
                      },
                      child: Text('Add coins'),
                    ),
                  ],
                );
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 200.0,
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('Usuarios/${widget.user.uid}/Achievements')
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
                  
                    

                  return GridView.builder(

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];
                      
                      return ShopItemDetail(
                        name: ds['name'],
                        price: ds['price'],
                        imagePath: ds['image'],
                        added: ds['added'],
                        index: snapshot.data.documents[index].documentID,
                        user: widget.user,
                      );
                    },
                    itemCount: snapshot.data.documents.length,
                  );
                },
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }
}
