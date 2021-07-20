import 'package:flutter/material.dart';
import 'package:medico/Database/AppointData.dart';
import 'package:medico/Forms/log_in.dart';
import 'package:medico/Forms/register.dart';
import 'package:medico/Pages/bottom_nav.dart';
import 'package:medico/Pharma/mainScreen.dart';
import '../Wizards/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medico/constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
AppointData appointmentData = AppointData();
bool enableAppointButton = false;

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if (_auth.currentUser != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BotNavBar(),
          ),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle topTxt = TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.17,
      fontWeight: FontWeight.bold,
      fontFamily: 'Bebas',
      color: Colors.white,
      // letterSpacing: 3,
    );
    TextStyle midText = TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontFamily: 'Poiret',
      color: Colors.white,
    );

    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: FractionalOffset.bottomCenter,
          stops: [0.1, 0.6, 1],
          colors: [
            Colors.teal,
            Colors.green,
            Colors.white,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  'Welcome To',
                  style: topTxt,
                ),
                Text(
                  'Medico',
                  style: topTxt,
                ),
                Text(
                  'All your health needs',
                  style: midText,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Summed upped in one place',
                  style: midText,
                ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Buttons(
                circleRadius: 50.0,
                txt: 'Sign In',
                click: () {
                  Navigator.pushNamed(context, LogIn.id);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Buttons(
                txt: 'Sign Up',
                circleRadius: 50.0,
                click: () {
                  Navigator.pushNamed(context, SignUp.id);
                },
              ),
              SizedBox(
                height: 50,
              ),
            ])
          ],
        ),
      ),
    ));
  }
}
