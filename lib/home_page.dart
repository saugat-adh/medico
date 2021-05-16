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
            SizedBox(height: 200,),
            Buttons(
              txt: 'Sign In',
              click: (){
                Navigator.pushNamed(context, '/signIn');
              },
            ),
            SizedBox(height: 20,),
            Buttons(
              txt: 'Sign Up',
              click: (){
                Navigator.pushNamed(context, '/signUp');
              },
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}




