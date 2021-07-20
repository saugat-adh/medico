import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/details/Components/custom_app_bar.dart';
import 'package:medico/details/Components/body.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';



final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DetailsScreen extends StatefulWidget {

  static String routeName="/details";

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {



  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments=
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar:CustomAppBar(arguments.product.rating),
      body: Body(
      ),


    );
  }
}




class ProductDetailsArguments{
  final Product product;
  ProductDetailsArguments({@required this.product});
}
