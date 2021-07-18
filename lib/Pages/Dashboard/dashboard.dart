import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medico/Notifications/NotificationsPage.dart';
import 'package:medico/Pages/Dashboard/docPanel.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/Pages/shop/cart/cart_screen.dart';
import 'package:medico/Setting/SettingsPage.dart';
import 'package:medico/Wizards/icons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medico/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bottom_nav.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


class Dash1 extends StatefulWidget {
  @override
  _Dash1State createState() => _Dash1State();
}

class _Dash1State extends State<Dash1> {

  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  PickedFile image;
  @override
  void initState() {
    super.initState();
  }

  final myControllerHeight = TextEditingController();
  final myControllerWeight = TextEditingController();

  @override
  void dispose() {
    //Cleanup Controller when widget is disposed
    myControllerHeight.dispose();
    myControllerWeight.dispose();
    super.dispose();
  }

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
                      _selectUserPic(),
                      _buildUserName(),
                      _buildSettingPanel(),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _covidTracker(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  userType == 'doctors' ? _doctorPanel() : SizedBox(height: 1,),
                  _patientDetails(),
                ],
              ),
            )),
      ],
    );
  }

  _doctorPanel() {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => DocPanel()),
        );
      },
      child: Column(
        children: [
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Center(child: Text('Doctor panel')),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
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
      right: 20,
      child: (imageUrl != null)
          ? CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              backgroundImage: NetworkImage(imageUrl),
            )
          : CircleAvatar(
              backgroundColor: Colors.white,
              radius: 70,
              backgroundImage: new AssetImage('images/CircleProfile.png')),
    );
  }

  _selectUserPic() {
    return Positioned(
      bottom: 75,
      right: 20,
      child: InkWell(
        onTap: () {
          uploadImage();
        },
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 25.0,
        ),
      ),
    );
  }

  _buildUserName() {
    return Positioned(
        bottom: 90,
        left: 40,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                'Hello,',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Droid Sans'),
              ),
              Text(
                userName != null ? userName : '',
                maxLines: 2,
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Roboto'),
              ),
            ])));
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
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  ico: Icon(
                    FeatherIcons.settings,
                  ),
                ),
                IcoBtn(
                  onClick: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  ico: Icon(
                    FeatherIcons.shoppingCart,
                  ),
                ),
                IcoBtn(
                  onClick: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()));
                  },
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
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Covid Cases In Nepal',
                      style: TextStyle(
                          color: Colors.black,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.8,
                              color: Color.fromARGB(255, 116, 112, 112),
                            ),
                          ],
                          fontSize: 13,
                          fontFamily: 'RobotoReg'),
                    ),
                  ],
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Total',
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 14,
                                fontFamily: 'RobotoReg',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.4, 2.4),
                                    blurRadius: 8.7,
                                    color: Color.fromARGB(100, 245, 217, 82),
                                  ),
                                ]),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            totalGrand,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.amber,
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
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Recovered',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontFamily: 'RobotoReg',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.4, 2.4),
                                    blurRadius: 8.7,
                                    color: Color.fromARGB(100, 158, 238, 93),
                                  ),
                                ]),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            totalRecovered,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontFamily: 'Droid Sans'),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.04),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Death',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: 'RobotoReg',
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(2.4, 2.4),
                                    blurRadius: 8.7,
                                    color: Color.fromARGB(100, 245, 84, 84),
                                  ),
                                ]),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02),
                          Text(
                            totalDeath,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: 'Droid Sans'),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ]),
    );
  }

  _patientDetails() {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width - 20,
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.001),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
              Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onLongPress: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content:
                              Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text('Height',
                                    style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'RobotoReg',
                                       ),
                                     ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                        ],
                                        decoration: InputDecoration(
                                            border: new OutlineInputBorder(),
                                            hintText: 'Enter your height'
                                        ),
                                        controller: myControllerHeight,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ElevatedButton(
                                              child: Text("Save"),
                                              onPressed: () {
                                                userHeight = myControllerHeight.text;
                                                _changeHeight();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Height Changed Successfully')));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => BotNavBar()));
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.teal),
                                              ),
                                             ),
                                            ElevatedButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                myControllerHeight.clear();
                                              },
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.teal),
                                              ),
                                            ),
                                          ]
                                        )
                                      ),
                                  ],
                                ),
                              ),
                        );
                      });

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.width * 0.04),
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
                      Text(
                        'Height',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'RobotoReg',
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        userHeight != null ? userHeight : '',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Droid Sans',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content:
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Weight',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'RobotoReg',
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                                    ],
                                    decoration: InputDecoration(
                                        border: new OutlineInputBorder(),
                                        hintText: 'Enter your weight'
                                    ),
                                    controller: myControllerWeight,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          ElevatedButton(
                                            child: Text("Save"),
                                            onPressed: () {
                                              userWeight = myControllerWeight.text;
                                              _changeWeight();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Weight Changed Successfully')));

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => BotNavBar()));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.teal),
                                            ),
                                          ),
                                          ElevatedButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              myControllerWeight.clear();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(Colors.teal),
                                            ),
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),
                        );
                      });

                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.width * 0.04),
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
                      Text(
                        'Weight',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'RobotoReg',
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                      Text(
                        userWeight != null ? userWeight : '',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Droid Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.width * 0.04),
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
                    Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'RobotoReg',
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      ageFinal != null ? ageFinal : '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Droid Sans',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                    vertical: MediaQuery.of(context).size.width * 0.04),
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
                    Text(
                      'BMI',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'RobotoReg',
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    Text(
                      bmiFixed != null ? bmiFixed : '',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Droid Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ]),
    );
  }

  uploadImage() async {
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);
      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('UserProfile')
            .child(firebaseUser.uid)
            .child(firebaseUser.uid)
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection(userType)
            .doc(firebaseUser.uid)
            .update({"ImgUrl": downloadUrl});
        setState(() {
          imageUrl = downloadUrl;
          print("Profile Picture Uploaded");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile Picture Uploaded')));
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  _changeHeight() async {

    if (firebaseUser != null && userType == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .update({'height': myControllerHeight.text});

    if (firebaseUser != null && userType == 'doctors')
      await _firestore
          .collection("doctors").doc(firebaseUser.uid).update({'height': myControllerHeight.text});
  }


  _changeWeight() async {

    if (firebaseUser != null && userType == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .update({'weight': myControllerWeight.text});

    if (firebaseUser != null && userType == 'doctors')
      await _firestore
          .collection("doctors").doc(firebaseUser.uid).update({'weight': myControllerWeight.text});
  }


  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }
}
