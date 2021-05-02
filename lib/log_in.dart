import 'package:flutter/material.dart';
import 'button_and_text.dart';
import 'forms.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff444444),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: TopText(
                  txtFile: 'Sign In',
                ),
              )
            ),
            Center(
              child: InForm(
                childNote: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    'Form Goes Here',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Buttons(colour: Color(0xff52912E), dim: EdgeInsets.fromLTRB(0, 20, 0, 20), txt: 'Continue'),
            Buttons(colour: Color(0xff000000), dim: EdgeInsets.fromLTRB(0, 0, 0, 0), txt: 'Back', click: (){ Navigator.pop(context); })
          ],
        ),
      ),
    );
  }
}







