import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShopItemDetail extends StatefulWidget {
  final name, imagePath;
  int price, actualMoney;
  bool added;
  FirebaseUser user;
  dynamic index;

  ShopItemDetail(
      {this.name,
      this.price,
      this.imagePath,
      this.added,
      this.actualMoney,
      this.user,
      this.index});

  @override
  _ShopItemDetailState createState() => _ShopItemDetailState();
}

class _ShopItemDetailState extends State<ShopItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text('Buy ${widget.name}'),
                content: Text('Are you sure you want to buy ${widget.name} ?'),
                actions: <Widget>[
                  //Primer streamBuilder para las monedas
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

                      return FlatButton(
                        child: Text('Buy'),
                        onPressed: () {
                          dynamic ds = snapshot.data.documents[0];

                          if (ds['money'] >= widget.price &&
                              widget.added == false) {
                            Firestore.instance
                                .collection(
                                    'Usuarios/${widget.user.uid}/Achievements')
                                .document(widget.index)
                                .updateData({'added': true});
                            setState(() {
                              widget.added = true;
                            });

                            print('valores validos');
                            Firestore.instance
                                .collection('Usuarios/${widget.user.uid}/Coins')
                                .document(snapshot.data.documents[0].documentID)
                                .updateData(
                                    {'money': ds['money'] - widget.price});

                            Navigator.of(context).pop('Ok');
                          } else {
                            print('No tienes suficiente dinero');
                            Navigator.of(context).pop('Ok');
                          }
                        },
                      );
                    },
                  ),
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop('Cancel');
                    },
                  ),
                ],
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Hero(
                  tag: widget.imagePath,
                  child: Container(
                    height: 90.0,
                    width: 90.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                Text(
                  widget.price.toString(),
                  style: TextStyle(
                    color: Color(0xFFCC8053),
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Color(0xFF575E67),
                    fontSize: 14.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (!widget.added) ...[
                        Icon(
                          Icons.shopping_basket,
                          color: Color(0xFFD17E50),
                          size: 12.0,
                        ),
                        Text(
                          'Buy ${widget.name}',
                          style: TextStyle(
                            color: Color(0xFFD17E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                      if (widget.added) ...[
                        Icon(
                          Icons.star,
                          color: Color(0xFFD17E50),
                          size: 12.0,
                        ),
                        Text(
                          'In property',
                          style: TextStyle(
                            color: Color(0xFFD17E50),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Color(0xFFD17E50),
                          size: 12.0,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
