import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medico/Pages/shop/cart/components/Cart.dart';
import 'package:medico/Pages/shop/cart/components/cart_item_card.dart';
import 'package:medico/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestore
            .collection(userType)
            .doc(firebaseUser.uid)
            .collection('cart')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08),
            child: Column(
              children: snapshot.data.docs.map((document) {
                StreamBuilder(
                  stream: _firestore
                      .collection('product')
                      .where(FieldPath.documentId , isEqualTo: document['UID'])
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> abc) {
                    return ListView.builder(
                      itemCount: demoCarts.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: Key(demoCarts[index].product.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              demoCarts.removeAt(index);
                            });
                          },
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE6E6),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Spacer(),
                                SvgPicture.asset("images/feather/trash-2.svg"),
                              ],
                            ),
                          ),
                          child: CartCard(cart: demoCarts[index]),
                        ),
                      ),
                    );
                  }
                );
              }).tolist(),
            ),
          );
        });
  }
}
