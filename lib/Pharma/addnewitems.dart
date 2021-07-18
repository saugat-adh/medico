import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

String pName;
String pDescription;
String pQuantity;
String pPrice;


class AddNewItem extends StatefulWidget {

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<AddNewItem> {

  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final productQuantity = TextEditingController();
  final productPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Add Items', style: TextStyle(fontFamily: 'Times New Roman'),),
          elevation: 0,
          backgroundColor: Colors.teal,

        ),
        body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04),
                    Text("Enter the details of your product", style: TextStyle(fontSize: 18),),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.03),
                    _item(
                      name: 'Name',
                      controller: productName,
                      hintText: 'Name of your product',
                      type: TextInputType.text,
                    ),
                    _item(
                      name: 'Description',
                      controller: productDescription,
                      hintText: 'Description of your product',
                      type: TextInputType.text,
                    ),
                    _item(
                      name: 'Quantity',
                      controller: productQuantity,
                      hintText: 'Quantity of your product',
                      type: TextInputType.number,
                    ),
                    _item(
                      name: 'Price',
                      controller: productPrice,
                      hintText: 'Price of your product',
                      type: TextInputType.number,
                    ),
                    // _productName(),
                    // _productDescription(),
                    // _productQuantity(),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    _productImage(),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    _submit(),
                  ],
                ),
              ),
            ),
        ),
    );
  }



  _productImage(){
    return  Container(
      color: Colors.teal,
      height: MediaQuery.of(context).size.width*0.3,
      child: Image(
        image: new AssetImage('images/upload.jpg'),
      ),
    );
  }

  _submit(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        ElevatedButton(
          child: Text('Add' ,style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          onPressed: () {
            pName = productName.text;
            pDescription = productDescription.text;
            pQuantity = productQuantity.text;
            pPrice = productPrice.text;
            _upload();
          },
        ),

        ElevatedButton(
          child: Text('Cancel' ,style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          onPressed: () {

          },
        ),

      ]
    );
  }

}

class _item extends StatelessWidget {

  final String name;
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;

  const _item({
  Key key,
  this.name,
  this.hintText,
  this.controller,
  this.type,
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width - 5,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          new Flexible(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: type,
                controller: controller,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  border: new OutlineInputBorder(),
                  hintText: hintText,
                ),

              ),
            ),
          ),
        ],
      ),
    );
  }

}

_upload() async {
  await _firestore
      .collection('products')
      .add({
            'Name': pName,
            'Description' : pDescription,
            'Quantity' : pQuantity,
            'Price' : pPrice,
          });
}