
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/product_card.dart';
import 'package:medico/Pages/shop/components/section_title.dart';
import 'package:medico/details/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Product.dart';
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class PopUpProducts extends StatelessWidget {
  const PopUpProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .height * 0.01),
          child: SectionTitle(text: "Popular Products", press: () {},),
        ),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.01),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>
                    (stream: _firestore.collection("products").snapshots(),
                      builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> dataSnapshot) {
                        if (!dataSnapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: dataSnapshot.data.docs.map((document) {
                                return ProductCard(
                                  imgURL: document['ProductImageUrl'],
                                  productPrice: document['Price'],
                                  title: document['Name'],
                                  quantity: document['Quantity'],
                                  description: document['Description'],
                                  // press: () { Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (BuildContext context) => DoctorExp(document)),
                                  // );
                                  // },
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }
                  ),

                ],
              ),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),

            ],
          ),
        )
      ],
    );
  }
}
