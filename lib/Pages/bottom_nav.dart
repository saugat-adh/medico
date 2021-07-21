import 'package:flutter/material.dart';
import 'package:medico/Pages/Dashboard/dashboard.dart';
import 'package:medico/Pharma/mainScreen.dart';
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
    userType == 'admin' ? _gotoNavigate() : _getElseData();
    super.initState();
  }

  _getElseData() {
    getData();

  }

  _gotoNavigate() {
    Future.delayed(Duration.zero, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder:
                (BuildContext context) => Pharma()
        ),
            (route) => false,
      );
    });
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

}


