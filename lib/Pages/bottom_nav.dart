import 'package:flutter/material.dart';
import 'package:medico/Pages/Dashboard/dashboard.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'appointments/appointment.dart';
import 'shop/shop.dart';
import 'package:medico/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BotNavBar extends StatefulWidget {
  static const String id = 'bot_nav_bar';

  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;
  List pageKeys = ['Page1', 'Page2', 'Page3'];

  final List<Widget> _children = [
    Dash1(),
    Dash2(),
    Dash3(),
  ];


  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getData();
    _fetchName();
    _fetchHeight();
    _fetchWeight();
    _fetchBMI();
    _fetchAge();
    _fetchImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _children[_selectedIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.dashboard_outlined),
                title: Text("Dashboard "),
                selectedColor: Colors.teal,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.medical_services_outlined),
                title: Text("Appointments"),
                selectedColor: Color(0xff8f3d3c),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                title: Text("Shop"),
                selectedColor: Colors.purple,
              ),
            ],
          ),
        ),
    );
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

  Future<String> _fetchHeight() async {


    if (firebaseUser != null && userType == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        userHeight = documentSnapshot.get('height');
        print(userHeight);
      }).catchError((e) {
        print(e);
      });

    if (firebaseUser != null && userType == 'doctors')
      await _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        userHeight = documentSnapshot.get('height');
        print(userHeight);
      }).catchError((e) {
        print(e);
      });

    return userHeight;
  }

  Future<String> _fetchWeight() async {

    if (firebaseUser != null && userType == 'patients')
      await _firestore
          .collection('patients')
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        userWeight = documentSnapshot.get('weight');
        print(userWeight);
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
        print(userWeight);
      }).catchError((e) {
        print(e);
      });

    return userWeight;
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

}


