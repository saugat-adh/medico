import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/constants.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class CheckoutCard extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width*0.05,
        horizontal: MediaQuery.of(context).size.width*0.1,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width*0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: total_price.toString(),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.orange[800],
                    ),

                    icon: Icon(FeatherIcons.dollarSign,size: 20,),
                    label: Text(
                      "Check Out".toUpperCase(),
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: (){
                      notifyOwners();

                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  notifyOwners()async{
    final firebaseUser = _auth.currentUser;
    String user;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
      }).catchError((e) {
        print(e);
      });

    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection(user.toString())
        .doc(firebaseUser.uid)
    .collection('cart').get();


    productSnapshot.docs.forEach((productId) async{
      Map data = productId.data();
      String productUid = data['UID'];
      DocumentSnapshot singleProductSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productUid).get();
      Map owner = singleProductSnapshot.data();
      sendNotification(
          productOwnerUid: owner['productOwner'],
        buyerName: data['username'],
        buyerAddress: data['address'],
        buyerPNo: data['cellNumber'],
        productNames: owner['Name']
      );
      // sendNotification();

    });
  }

  sendNotification({
    @required String productOwnerUid,
    @required String buyerName,
    @required String buyerPNo,
    @required String buyerAddress,
    @required String productNames
  }){
    FirebaseFirestore.instance.collection("StoreAdmin").doc(productOwnerUid).collection('item').add({
      "buyerName":buyerName,
      "address":buyerAddress,
      "cellNumber":buyerPNo,
      "product":productNames
    });

  }

}