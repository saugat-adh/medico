import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
import 'package:medico/models/userModel.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bottom_nav.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


final myControllerHeight = TextEditingController();
final myControllerWeight = TextEditingController();


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
    _fetchName();
    _fetchData( 'height' , userHeight );
    _fetchData( 'weight' , userWeight) ;
    _fetchBMI();
    _fetchAge();
    _fetchImage();
    super.initState();
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
                  userType == 'doctors'
                      ? _doctorPanel()
                      : SizedBox(
                          height: 1,
                        ),
                  _patientDetails(),
                ],
              ),
            )),
      ],
    );
  }

  _doctorPanel() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => DocPanel()),
        );
      },
      child: Column(
        children: [
          Container(
            //height: 150,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text('Doctor panel')),
            ),
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
                  _containerCovid( name : 'Total' , data: totalGrand, color1 : Colors.amber , color2: Color.fromARGB(00, 245, 217, 82), ),
                  _containerCovid( name : 'Recovered' , data: totalRecovered, color1 : Colors.green , color2: Color.fromARGB(100, 158, 238, 93), ),
                  _containerCovid( name : 'Death' , data: totalDeath, color1 : Colors.red , color2: Color.fromARGB(100, 245, 84, 84), ),

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
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
                    _containerPatientG(name: 'Height' , data: userHeight , dataSnack: "Height Changed Successfully", hintText: 'Enter the height in cm', myController: myControllerHeight, ),
                    _containerPatientG(name: 'Weight' , data: userWeight , dataSnack: "Weight Changed Successfully", hintText: 'Enter the weight in kg', myController: myControllerWeight, ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                      _containerPatient(name: 'Age' , data: ageFinal),
                      _containerPatient(name: 'BMI' , data: bmiFixed )
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



  signOut() async {
    await _auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>HomePage()),
            (Route<dynamic> route) => false);
  }
}


class _containerCovid extends StatelessWidget {

  final String name;
  final String data;
  final Color color1;
  final Color color2;

  const _containerCovid({
    Key key,
    this.name,
    this.data,
    this.color1,
    this.color2
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {
   return Expanded(
     child: Container(
       padding: EdgeInsets.symmetric(
           horizontal: MediaQuery.of(context).size.width * 0.05,
           vertical: MediaQuery.of(context).size.width * 0.04),
       child: Column(
         children: <Widget>[
           Text(
             name,
             maxLines: 1,
             style: TextStyle(
                 color: color1,
                 fontSize: 14,
                 fontFamily: 'RobotoReg',
                 shadows: <Shadow>[
                   Shadow(
                     offset: Offset(2.4, 2.4),
                     blurRadius: 8.7,
                     color: color2
                   ),
                 ]),
           ),
           SizedBox(
               height: MediaQuery.of(context).size.width * 0.02),
           Text(
             data,
             maxLines: 1,
             style: TextStyle(
               color: color1,
               fontSize: 14,
               fontFamily: 'Droid Sans',
             ),
           )
         ],
       ),
     ),
   );
  }

}


class _containerPatientG extends StatelessWidget {

  final String name;
  String data;
  final String dataSnack;
  final String hintText;
  final TextEditingController myController;

  _containerPatientG({
    Key key,
    this.name,
    this.data,
    this.dataSnack,
    this.hintText,
    this.myController
  }) : super (key : key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          name,
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
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'))
                          ],
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(),
                              hintText: hintText),
                          controller: myController,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text("Save"),
                                  onPressed: () {
                                    data = myController.text;
                                    _changeData( name , myController);
                                    myController.clear();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            dataSnack)));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BotNavBar()));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.teal),
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    myController.clear();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.teal),
                                  ),
                                ),
                              ])),
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
              name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'RobotoReg',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.02),
            Text(
              data != null ? data : '',
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
    );
  }

}

class _containerPatient extends StatelessWidget {

  final String name;
  final String data;

  const _containerPatient({
    Key key,
    this.name,
    this.data,
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'RobotoReg',
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.02),
          Text(
            data != null ? data : '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Droid Sans',
            ),
          ),
        ],
      ),
    );
  }

}


_changeData( String name, TextEditingController controllerData  ) async {
  String fName = name.toLowerCase();
  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .update({fName: controllerData.text});

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection("doctors")
        .doc(firebaseUser.uid)
        .update({fName: controllerData.text});
}

Future<String> _fetchName() async {

  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userName = documentSnapshot.get('First name');
      print(userName);
      print(userType);
    }).catchError((e) {
      print(e);
    });

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection('doctors')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userName = documentSnapshot.get('First name');
      print(userName);
    }).catchError((e) {
      print(e);
    });
  return userName;
}

Future<String> _fetchData(String name, String data) async {


  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.get(name);
      print(data);
    }).catchError((e) {
      print(e);
    });

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection('doctors')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      data = documentSnapshot.get(name);
      print(data);
    }).catchError((e) {
      print(e);
    });

  return userHeight;
}

Future<String> _fetchAge() async {

  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      bornDate = documentSnapshot.get('DOB');
      DateTime bd = new DateFormat('dd/MM/yyyy').parse(bornDate);
      int age = today.year - bd.year;
      if (today.month < bd.month ||
          (today.month == bd.month && today.day < bd.day)) age = age - 1;
      print(age);
      ageFinal = age.toString();
    }).catchError((e) {
      print(e);
    });

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection('doctors')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      bornDate = documentSnapshot.get('DOB');
      DateTime bd = new DateFormat('dd/MM/yyyy').parse(bornDate);
      int age = today.year - bd.year;
      if (today.month < bd.month ||
          (today.month == bd.month && today.day < bd.day)) age = age - 1;
      print(age);
      ageFinal = age.toString();
    }).catchError((e) {
      print(e);
    });

  return ageFinal;
}

Future<String> _fetchBMI() async {

  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userWeight = documentSnapshot.get('weight');
      userHeight = documentSnapshot.get('height');
      w = double.parse(userWeight);
      h = double.parse(userHeight);
      bmi = (w / (h * h)) * 10000;
      bmiFixed = bmi.toStringAsFixed(2);
      print(bmiFixed);
    }).catchError((e) {
      print(e);
    });

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection('doctors')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userWeight = documentSnapshot.get('weight');
      userHeight = documentSnapshot.get('height');
      w = double.parse(userWeight);
      h = double.parse(userHeight);
      bmi = (w / (h * h)) * 10000;
      bmiFixed = bmi.toStringAsFixed(2);
      print(bmiFixed);
    }).catchError((e) {
      print(e);
    });

  return bmiFixed;
}

Future<String> _fetchImage() async {

  if (firebaseUser != null && userType == 'patients')
    await _firestore
        .collection('patients')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      imageUrl = documentSnapshot.get('ImgUrl');
    }).catchError((e) {
      print(e);
    });

  if (firebaseUser != null && userType == 'doctors')
    await _firestore
        .collection('doctors')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      imageUrl = documentSnapshot.get('ImgUrl');
    }).catchError((e) {
      print(e);
    });

  return imageUrl;
}

