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
            backgroundColor: Color(0xffF0F2F8),
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
                      _buildUserName(),
                      _buildSettingPanel(),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  _covidTracker(),
                  SizedBox(
                    height: 20,
                  ),
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
      top: 40,
      right:20,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
          backgroundImage: new AssetImage('images/CircleProfile.png')
      ),
    );
  }

  _buildUserName() {
    return Positioned(
        bottom: 90,
        left: 40,
        width: MediaQuery.of(context).size.width*0.5,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  'Hello,',
                style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Droid Sans'),
              ),

              FutureBuilder(
                future: _fetchName(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  String username = snapshot.data;
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text("Fetching data...",
                      maxLines: 2,
                      style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: 'Roboto'),
                    );
                  return Text(username,
                    maxLines: 2,
                    style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),
                  );
                },
              ),

            ]
          )

        )
    );
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
                IcoBtn(
                  onClick: () {},
                  ico: Icon(
                    FeatherIcons.settings,
                  ),
                ),
                IcoBtn(
                  onClick: () {},
                  ico: Icon(
                    FeatherIcons.shoppingCart,
                  ),
                ),
                IcoBtn(
                  onClick: () {},
                  ico: Icon(
                    FeatherIcons.bell,
                  ),
                ),
                IcoBtn(
                  ico: Icon(
                    FeatherIcons.logOut,
                  ),
                  onClick: () {
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
      height: 130,
      width: MediaQuery.of(context).size.width-20 ,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width*0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children:<Widget>[

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width*0.02),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Covid Cases In Nepal',
                      style: TextStyle(
                        color: Colors.black,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.5,0.5),
                            blurRadius: 1.8,
                            color: Color.fromARGB(255, 116, 112, 112),
                          ),
                        ],
                        fontSize: 15,
                        fontFamily: 'RobotoReg'),
                    ),
                  ],
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:<Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.05,
                          vertical: MediaQuery.of(context).size.width*0.04),

                      child: Column(
                        children: <Widget>[
                          Text('Total',
                            maxLines: 1,
                            style: TextStyle(color: Colors.amber,
                              fontSize: 14,
                              fontFamily: 'RobotoReg',
                              shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.4,2.4),
                                blurRadius: 8.7,
                              color: Color.fromARGB(100, 245, 217, 82),
                              ),]
                          ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width*0.02),
                          Text('540654',
                            maxLines: 1,
                            style: TextStyle(color: Colors.amber,
                              fontSize: 14,
                              fontFamily: 'Droid Sans',
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.05,
                          vertical: MediaQuery.of(context).size.width*0.04),
                      child: Column(
                        children: <Widget>[
                          Text('Recovered',style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontFamily: 'RobotoReg',
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.4,2.4),
                                  blurRadius: 8.7,
                                  color: Color.fromARGB(100, 158, 238, 93),
                                ),]
                          ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width*0.02),
                          Text('420765',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontFamily: 'Droid Sans'
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.05,
                          vertical: MediaQuery.of(context).size.width*0.04),
                      child: Column(
                        children: <Widget>[
                          Text('Death',style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontFamily: 'RobotoReg',
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(2.4,2.4),
                                  blurRadius: 8.7,
                                  color: Color.fromARGB(100, 245, 84, 84),
                                ),]
                          ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.width*0.02),
                          Text('1076',
                            maxLines: 1,
                            style: TextStyle(color: Colors.red, fontSize: 14, fontFamily: 'Droid Sans'),)
                        ],
                      ),
                    ),
                  ),
                ]
            ),
          ]),
    );
  }

  _patientDetails() {
    return Container(
        height: 250.0,
        width: MediaQuery.of(context).size.width - 20,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.001),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Container(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.45,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width*0.05,
                            vertical: MediaQuery.of(context).size.width*0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                              blurRadius: 11.2,
                            )
                          ],
                        ),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Text('Height',style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'RobotoReg',
                            ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width*0.02),
                            FutureBuilder(
                              future: _fetchHeight(),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                String height = snapshot.data;
                                if (snapshot.connectionState != ConnectionState.done)
                                  return Text("Fetching data...",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Droid Sans',),
                                  );
                                return Text(height,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Droid Sans',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.12,
                        width: MediaQuery.of(context).size.width*0.45,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width*0.05,
                            vertical: MediaQuery.of(context).size.width*0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                              blurRadius: 11.2,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Weight',style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'RobotoReg',
                            ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width*0.02),
                            FutureBuilder(
                              future: _fetchWeight(),
                              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                                String weight = snapshot.data;
                                if (snapshot.connectionState != ConnectionState.done)
                                  return Text("Fetching data...",
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Droid Sans',),
                                  );
                                return Text(weight,
                                  maxLines: 2,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Droid Sans',
                                  ),
                                );
                              },
                            ),
                          ],
                      ),
                    ),
                  ]
              ),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.45,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width*0.05,
                          vertical: MediaQuery.of(context).size.width*0.04),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.5,
                            blurRadius: 11.2,
                          )
                        ],
                      ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Age',style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'RobotoReg',
                            ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width*0.02),
                            Text('21',
                              style: TextStyle(color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Droid Sans',
                              ),
                            )
                          ],
                        ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.12,
                      width: MediaQuery.of(context).size.width*0.45,
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width*0.05,
                            vertical: MediaQuery.of(context).size.width*0.04),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0.5,
                              blurRadius: 11.2,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('BMI',style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'RobotoReg',
                            ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.width*0.02),
                            Text('88',
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Droid Sans'
                              ),
                            )
                          ],
                        ),
                      ),
                  ]
              ),
            ]),
    );
  }


  Future<String> _fetchName() async {
    String username;
    String height;
    String weight;

    final firebaseUser = await _auth.currentUser;
    if (firebaseUser != null)
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        username = documentSnapshot.get('First name');
        height = documentSnapshot.get('height');
        weight = documentSnapshot.get('weight');
        print (username);
        print (height);
        print (weight);
      }).catchError((e) {
        print(e);
      });
    return username;
  }

  Future<String> _fetchHeight() async {
    String height;

    final firebaseUser = await _auth.currentUser;
    if (firebaseUser != null)
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        height = documentSnapshot.get('height');
        print (height);
      }).catchError((e) {
        print(e);
      });
    return height;
  }

  Future<String> _fetchWeight() async {
    String weight;

    final firebaseUser = await _auth.currentUser;
    if (firebaseUser != null)
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        weight = documentSnapshot.get('weight');
        print (weight);
      }).catchError((e) {
        print(e);
      });
    return weight;
  }


  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }
}

