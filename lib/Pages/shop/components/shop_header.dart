import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medico/Components/search_field.dart';
import 'package:medico/Pages/shop/cart/cart_screen.dart';
import 'package:medico/constants.dart';
import '../price_calculator.dart';
import 'product_list.dart';



import 'icon_btn_with_counter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class ProductDataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {

    for(var i =0 ; i < recentProductData.length ; i++){
      if(recentProductData[i] == query){
        recentProductData.remove(recentProductData[i]);
      }
    }
    recentProductData.add(query);
    return ProductListSearch(title: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentProductData.reversed.toList()
        : productData.where((element) => element.startsWith(query)).toList();
//
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
        },
        leading: Icon(Icons.search_rounded),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring((query.length)),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

}

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchField(),
              IconButtonWithCounter(
                svgSrc: "images/feather/shopping-cart.svg",
                numOfItems: 1,
                press: (){
                  price();
                  Navigator.pushNamed(context, CartScreen.routeName);}
                ,
              ),

            ],
          ),
        ],
      ),

      
    );
  }
}