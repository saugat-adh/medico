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
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.fill,
            )
        ),
        constraints: BoxConstraints(
          minWidth: double.minPositive,
          minHeight: double.minPositive,
          maxWidth: double.maxFinite,
          maxHeight: double.maxFinite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            SizedBox(height: 290,),
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
    ));
  }
}




