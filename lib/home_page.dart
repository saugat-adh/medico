import 'package:flutter/material.dart';
import 'package:medico/log_in.dart';
import 'button_and_text.dart';

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
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: TopText(
                txtFile: 'Welcome To',
              )
            ),
            TopText(
              txtFile: 'Medico',
            ),
            MidText(
              txtFile: 'All your health needs',
              dime: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            MidText(
              txtFile: 'Summed up in one place',
            ),
            Buttons(
              colour: Color(0xff52912E),
              dim: EdgeInsets.fromLTRB(0, 200, 0, 0),
              txt: 'Sign In',
              click: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LogIn();
                }));
              },
            ),
            Buttons(
              colour: Color(0xff444444),
              dim: EdgeInsets.fromLTRB(0, 20, 0, 40),
              txt: 'Sign Up',
              click: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LogIn();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}




