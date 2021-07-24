import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medico/Pages/shop/components/product_card.dart';
import 'package:medico/details/details_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;

class ProductListSearch extends StatelessWidget {
 ProductListSearch({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('products')
          .where('Name', isEqualTo: title)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Container(child: Text('No results found'))),
            ],
          );
        } else {
          return Column(
            children: snapshot.data.docs.map((document) {
              if (document.id != firebaseUser.uid) {
                return ProductCard(
                  imgURL: document['ProductImageUrl'],
                  productPrice: document['Price'],
                  title: document['Name'],
                  quantity: document['Quantity'],
                  description: document['Description'],
                  press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DetailsScreen(document)),
                  );
                  },
                );
              } else {
                return Center(child: Text(''));
              }
            }).toList(),
          );
        }
      },
    );
  }
}
