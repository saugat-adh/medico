import 'package:flutter/material.dart';
import 'Wizards/text.dart';
import 'Wizards/buttons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
              //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: TopText(
                txtFile: 'Welcome To',
                colour: Colors.white,
              )
            ),
            TopText(
              txtFile: 'Medico',
                colour: Colors.white
            ),
            MidText(
              txtFile: 'All your health needs',
              dime: EdgeInsets.fromLTRB(0, 20, 0, 0),
                colour: Colors.white
            ),
            MidText(
              txtFile: 'Summed up in one place',
                colour: Colors.white,
              dime: EdgeInsets.fromLTRB(0, 0, 0, 100),
            ),
            Buttons(
              colour: Colors.white,
              dim: EdgeInsets.fromLTRB(0, 200, 0, 0),
              txt: 'Sign In',
              col: Color(0xff56AC81),
              click: (){
                Navigator.pushNamed(context, '/signIn');
              },
            ),
            Buttons(
              colour: Colors.white,
              dim: EdgeInsets.fromLTRB(0, 20, 0, 40),
              txt: 'Sign Up',
              col: Color(0xff000000),
              click: (){
                Navigator.pushNamed(context, '/signUp');
              },
            )
          ],
        ),
      ),
    );
  }
}




