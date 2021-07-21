import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/Product.dart';


import 'Components/productDescription.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;




class DetailsScreen extends StatefulWidget {

  final QueryDocumentSnapshot docs;

  const DetailsScreen(this.docs);

  static String routeName="/details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(widget.docs['Name']),
      backgroundColor: Colors.blue,
      ),
        backgroundColor: Color(0xFFF5F6F9),
        body: Row(
          children:[
           ProductDescription(
          widget.docs
          ),
          ]
      ),






      ),
    );
  }
}




class ProductDetailsArguments{
  final Product product;
  ProductDetailsArguments({@required this.product});
}
