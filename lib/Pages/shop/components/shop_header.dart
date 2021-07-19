import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medico/Components/search_field.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';
import 'package:medico/Pages/shop/cart/cart_screen.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/Pages/shop/components/product_card.dart';


import 'icon_btn_with_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ShopHeader extends StatelessWidget {
  ShopHeader({this.title});

  final String title;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SearchField(txt: 'Search Meds...',),
              IconButtonWithCounter(
                svgSrc: "images/feather/shopping-cart.svg",
                numOfItems: 1,
                press: ()=> Navigator.pushNamed(context, CartScreen.routeName)
                ,
              ),

            ],
          ),
        ],
      ),

      
    );
  }
}