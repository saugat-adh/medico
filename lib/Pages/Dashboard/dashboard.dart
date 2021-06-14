import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/Pages/shop/cart/cart_screen.dart';
import 'package:medico/Wizards/icons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Dash1 extends StatefulWidget {
  @override
  _Dash1State createState() => _Dash1State();
}

class _Dash1State extends State<Dash1> {
  String totalRecovered = '';
  String totalDeath = '';
  String totalGrand = '';
  String imageUrl;
  bool isLoading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await getApiData();
  }

  getApiData() async {
    String url = "https://api.covid19api.com/summary";
    var resposnse = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(resposnse.body);
    try {
      setState(() {
        isLoading = true;
      });
      jsonData['Countries'].forEach((country) {
        if (country['Country'] == "Nepal") {
          totalRecovered = country['TotalRecovered'].toString();
          totalDeath = country['TotalDeaths'].toString();
          totalGrand = country['TotalConfirmed'].toString();
        }
      });
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
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
      right: 20,
      child: (imageUrl != null)
          ? CircleAvatar(
          backgroundColor: Colors.white,
          radius: 70,
          backgroundImage: NetworkImage(imageUrl),
      ) :
      CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70,
            backgroundImage: new AssetImage('images/CircleProfile.png')
        ),
    );
  }

  _selectUserPic() {
    return  Positioned(
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
              FutureBuilder(
                future: _fetchName(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  String username = snapshot.data;
                  if (snapshot.connectionState != ConnectionState.done)
                    return Text(
                      "Fetching data...",
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Roboto'),
                    );
                  return Text(
                    username,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto'),
                  );
                },
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
                  onClick: () {},
                  ico: Icon(
                    FeatherIcons.settings,
                  ),
                ),
                IcoBtn(
                  onClick: () => Navigator.pushNamed(context, CartScreen.routeName),
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
                          fontSize: 15,
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
                      'Height',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'RobotoReg',
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                    FutureBuilder(
                      future: _fetchHeight(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        String height = snapshot.data;
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Fetching data...",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Droid Sans',
                            ),
                          );
                        return Text(
                          height,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
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
                    FutureBuilder(
                      future: _fetchWeight(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        String weight = snapshot.data;
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Fetching data...",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Droid Sans',
                            ),
                          );
                        return Text(
                          weight,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Droid Sans',
                          ),
                        );
                      },
                    ),
                  ],
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
                    FutureBuilder(
                      future: _fetchAge(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        String age = snapshot.data;
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Fetching data...",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Droid Sans',
                            ),
                          );
                        return Text(
                          age,
                          style: TextStyle(
                            color: Colors.black,
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
                    FutureBuilder(
                      future: _fetchBMI(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        String bmi = snapshot.data;
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text(
                            "Fetching data...",
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Droid Sans',
                            ),
                          );
                        return Text(
                          bmi.toString(),
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Droid Sans',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ]),
    );
  }

  Future<String> _fetchName() async {
    String username;
    String user;
    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
        print(user);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        username = documentSnapshot.get('First name');
        print(username);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'doctors')
      await _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        username = documentSnapshot.get('First name');
        print(username);
      }).catchError((e) {
        print(e);
      });
    return username;
  }

  Future<String> _fetchHeight() async {
    String height;
    String user;

    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
        print(user);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        height = documentSnapshot.get('height');
        print(height);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'doctors')
      await _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        height = documentSnapshot.get('height');
        print(height);
      }).catchError((e) {
        print(e);
      });

    return height;
  }

  Future<String> _fetchWeight() async {
    String weight;
    String user;

    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
        print(user);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        weight = documentSnapshot.get('weight');
        print(weight);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'doctors')
      await _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        weight = documentSnapshot.get('weight');
        print(weight);
      }).catchError((e) {
        print(e);
      });

    return weight;
  }

  Future<String> _fetchAge() async {
    String bornDate;
    DateTime today = DateTime.now();
    String ageFinal;
    String user;

    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
        print(user);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'patients')
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

    if (firebaseUser != null && user == 'doctors')
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
    String weight;
    String height;
    String user;
    String bmiFixed;
    double bmi, h, w;

    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
          .collection('AllUsers')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        user = documentSnapshot.get('User');
        print(user);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        weight = documentSnapshot.get('weight');
        height = documentSnapshot.get('height');
        w = double.parse(weight);
        h = double.parse(height);
        bmi = (w / (h * h)) * 10000;
        bmiFixed = bmi.toStringAsFixed(2);
        print(bmiFixed);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && user == 'doctors')
      await _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        weight = documentSnapshot.get('weight');
        height = documentSnapshot.get('height');
        w = double.parse(weight);
        h = double.parse(height);
        bmi = (w / (h * h)) * 10000;
        bmiFixed = bmi.toStringAsFixed(2);
        print(bmiFixed);
      }).catchError((e) {
        print(e);
      });

    return bmiFixed;
  }

  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted){
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
            .child('UserProfile/imageName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }
}
