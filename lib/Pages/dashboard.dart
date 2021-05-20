import 'package:flutter/material.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/Wizards/icons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class Dash1 extends StatefulWidget {
  @override
  _Dash1State createState() => _Dash1State();
}

class _Dash1State extends State<Dash1> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      _buildBackgroundCover(),
                      _buildUserPic(),
                      _buildSettingPanel(),
                    ],
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  _covidTracker(),
                  SizedBox(height: 10,),
                  _patientDetails(),
                ],
              ),
            )),
      ],
    );
  }

  _buildBackgroundCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.teal,
          ],
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
    );
  }

  _buildUserPic() {
    return Positioned(
        top: 50,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
        ));
  }

  _buildSettingPanel() {
    return Positioned(
        bottom: -35,
        child: Container(
          height: 70,
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ],
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IcoBtn(ico: Icon(
                  FeatherIcons.settings,
                ),),
                IcoBtn(ico: Icon(
                  FeatherIcons.shoppingCart,
                ),),
                IcoBtn(ico: Icon(
                  FeatherIcons.bell,
                ),),
                IcoBtn(ico: Icon(
                  FeatherIcons.logOut,
                ),
                onClick:(){
                  signOut();
                },
                ),
              ],
            ),
          ),
        ));
  }

  _covidTracker() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5.5,
            blurRadius: 5.5,
          )
        ],
      ),
      child: Center(
        child: Text(
          'This will contain Covid Tracker',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Lato'),
        ),
      ),
    );
  }

  _patientDetails() {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(28)),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.grey,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 5.5,
            blurRadius: 5.5,
          )
        ],
      ),
      child: Center(
        child: Text(
          'This will contain Patient Details',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Lato'),
        ),
      ),
    );
  }

  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }


}
