import 'package:flutter/material.dart';
import 'package:medico/log_in.dart';
import 'package:medico/register.dart';
import 'Wizards/buttons.dart';
import 'constants.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: [
                0.1,
                0.6,
                1
              ],
              colors: [
                Colors.teal,
                Colors.green,
                Colors.white,
              ],
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 190,),
              Center(
                child: Text(
                  'Welcome To',
                  style: topTxt,
                )
              ),
              Text(
                'Medico',
                style: topTxt,
              ),
              Text(
                'All your health needs',
                style: midText,
              ),
              SizedBox(height: 2,),
              Text(
                'Summed upped in one place',
                style: midText,
              ),
              SizedBox(height: 220,),
              Buttons(
                txt: 'Sign In',
                click: (){
                  Navigator.pushNamed(context, LogIn.id);
                },
              ),
              SizedBox(height: 20,),
              Buttons(
                txt: 'Sign Up',
                click: (){
                  Navigator.pushNamed(context, SignUp.id);
                },
              ),
              SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    ));
  }
}




