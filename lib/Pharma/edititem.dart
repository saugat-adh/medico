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
QuerySnapshot querySnap;
QueryDocumentSnapshot doc;
DocumentReference docRef;
String productImageUrl;

String pName;
String pDescription;
String pQuantity;
String pPrice;

bool pVisible = false;
bool show = false;

class EditItem extends StatefulWidget {

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditItem> {

  final productFind = TextEditingController();
  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final productQuantity = TextEditingController();
  final productPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              pVisible = false;
              show = false;
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Pharma()));
            },
          ),
        title: Text(
          'Edit Products', style: TextStyle(fontFamily: 'Times New Roman'),),
        elevation: 0,
        backgroundColor: Colors.teal,

      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _productFind(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  _productDetails(),

                ]),
          ),
        ),
      ),
    );
  }

  _productFind() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,
            child: TextFormField(
              controller: productFind,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                border: new OutlineInputBorder(),
                hintText: "Product Name",
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _checkProduct();
            },
            child: Text(
              'Search', style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
          )
        ]
    );
  }

  _checkProduct() async {
    querySnap = await _firestore.collection('products').where('Name', isEqualTo: productFind.text ).get();
    if (querySnap.docs.isNotEmpty) {
      doc = querySnap.docs[0];
      if (doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product Found')));
        setState(() {
          pVisible = true;
        });
        docRef = doc.reference;
        await docRef.get().then((DocumentSnapshot documentSnapshot) {
          pName = documentSnapshot.get('Name');
          pDescription = documentSnapshot.get('Description');
          pQuantity = documentSnapshot.get('Quantity');
          pPrice = documentSnapshot.get('Price');
          productImageUrl = documentSnapshot.get('ProductImageUrl');
        }).catchError((e) {
          print(e);
        });
      }
    }
    else {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product Not Found')));
        pVisible = false;
      });
    }
  }

  _productDetails() {
    return Visibility(
      visible: pVisible,
      child: Column(
            children: [
             Container(
               height: MediaQuery.of(context).size.height * 0.004,
               decoration: BoxDecoration(
                 color: Colors.teal,
               ),
             ),
              Container(
              height: MediaQuery.of(context).size.height * 0.004,
              decoration: BoxDecoration(
              color: Colors.teal,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  _product(
                   name: 'Name',
                   controller: productName ,
                   type: TextInputType.text,
                   hintText: pName,
                 ),
                  _product(
                    name: 'Description',
                    controller: productDescription ,
                    type: TextInputType.text,
                    hintText: pDescription,
                  ),
                _product(
                  name: 'Quantity',
                  controller: productQuantity ,
                  type: TextInputType.number,
                  hintText: pQuantity,
                ),
                _product(
                  name: 'Price',
                  controller: productPrice,
                  hintText: pPrice,
                  type: TextInputType.number,
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                _productImage(),
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                _submit(),
              ])
            ],
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
            child: Text('Update' ,style: TextStyle(color: Colors.white, fontSize: 14),
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
            child: Text('Delete' ,style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.teal),
            ),
            onPressed: () {
              pVisible = false;
              _deleteProduct();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Product Deleted Successfully')));
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
              pVisible = false;
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
    await docRef.update({
      'Name' : pName,
      'Description' : pDescription,
      'Quantity' : pQuantity,
      'Price' : pPrice,
      'ProductImageUrl' : productImageUrl,
    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product Updated Successfully'))));
    }

  _deleteProduct() async {
    await docRef.delete();
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

class _product extends StatelessWidget {

  final String name;
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;

  const _product({
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