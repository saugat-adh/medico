import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pharma/AdminShuftOrder.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medico/models/productModel.dart';

import 'addnewitems.dart';
import 'edititem.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
class Pharma extends StatefulWidget {

  @override
  _PharmaState createState() => _PharmaState();
}

class _PharmaState extends State<Pharma> {
  bool isDataAvailable = false;
  @override

  void initState() {
    super.initState();

    asyncHolder();
  }
  bool showNotification = false;
  @override
  Widget build(BuildContext context) {
    return isDataAvailable?displayAdminHomeScreen():Center(child: CircularProgressIndicator());
  }
  asyncHolder()async{

    if(true){
      await notificationData();
      isDataAvailable = true;

        setState(() {

        });

    }

  }

  notificationData()async{
    QuerySnapshot query = await FirebaseFirestore.instance.collection('StoreAdmin').doc(FirebaseAuth.instance.currentUser.uid).collection('item').get();
    query.docs.forEach((element) {
      print(element.id);
    });
    if(query.docs.length>0){
      showNotification = true;
    }

  }

   Widget notificationColor(){
    return Icon(showNotification?Icons.notifications_active:Icons.notifications,color:showNotification? Colors.pink:Colors.grey);
  }

  displayAdminHomeScreen(){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:  GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AdminShiftOrders()));
                  },
                    child: notificationColor()
          ),
        onPressed: (){
           Route route= MaterialPageRoute(builder: (context)=> AdminShiftOrders());
           Navigator.pushReplacement(context, route);
        },
        ),
        actions: [
          TextButton(onPressed: (){
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (BuildContext context) => HomePage())));
    },
              child: Text("Logout", style: TextStyle(
                color: Colors.teal, fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),))
        ],
      ),

      body: getAdminHomeScreenBody(),
    );
  }
  getAdminHomeScreenBody(){
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two, size: 200,),
            Padding(padding: EdgeInsets.only(top: 20.0),
            child: TextButton(
              onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (BuildContext context) => AddNewItem()));
            },
              child: Text("Add New Items", style: TextStyle(fontSize: 20.0, color: Colors.teal)),
            ),),
            Padding(padding: EdgeInsets.only(top: 20.0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EditItem()));
                },
                child: Text("Edit Products", style: TextStyle(fontSize: 20.0, color: Colors.teal)),
              ),)
          ],
        ),
      ),
    );
  }

}

