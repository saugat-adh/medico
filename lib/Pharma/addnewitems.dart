import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medico/Pharma/mainScreen.dart';
import 'package:permission_handler/permission_handler.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

final _firebaseStorage = FirebaseStorage.instance;
final _imagePicker = ImagePicker();
PickedFile image;
var file;
String productImageUrl;

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
      child: InkWell(
        onTap: () {
          uploadImage();
        },
        child: (productImageUrl != null) ?
          Image(image: new NetworkImage(productImageUrl))
          :Image(
          image: new AssetImage('images/upload.jpg'),
        ),
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
            _clear();
          },
        ),

        ElevatedButton(
          child: Text('Cancel' ,style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.teal),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Pharma()));
            _clear();
          },
        ),

      ]
    );
  }


  uploadImage() async {
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      file = File(image.path);
      if (image != null ) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wait, Image is being uploading ...')));
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('ProductImage')
            .child(productName.text)
            .child(productName.text)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          productImageUrl = downloadUrl;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Product Image Uploaded')));
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
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
      'ProductImageUrl' : productImageUrl,
            }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item Uploaded Successfully'))));
  }

  _clear() {
    productName.clear();
    productDescription.clear();
    productQuantity.clear();
    productPrice.clear();
    setState(() {
      productImageUrl = null;
    });

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

