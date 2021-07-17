import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pharma/AdminShuftOrder.dart';
import 'package:medico/Pages/home_page.dart';

import 'addnewitems.dart';
class Pharma extends StatefulWidget {

  @override
  _PharmaState createState() => _PharmaState();
}

class _PharmaState extends State<Pharma> {
  @override
  Widget build(BuildContext context) {
    return displayAdminHomeScreen();
  }

  displayAdminHomeScreen(){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(FeatherIcons.bell, color: Colors.red,),
        onPressed: (){
           Route route= MaterialPageRoute(builder: (context)=> AdminShiftOrders());
           Navigator.pushReplacement(context, route);
        },
        ),
        actions: [
          TextButton(onPressed: (){
            Route route= MaterialPageRoute(builder: (context)=> HomePage());
            Navigator.pushReplacement(context, route);
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
            ),)
          ],
        ),
      ),
    );
  }

}

