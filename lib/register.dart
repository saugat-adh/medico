import 'package:flutter/material.dart';
import 'Wizards/text.dart';
import 'Wizards/forms.dart';
import 'Wizards/buttons.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff56AC81),
          elevation: 0,
        ),
        backgroundColor: Color(0xff444444),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/form.png'),
                fit: BoxFit.cover,
              )
          ),
          child: Column(
            children: [
              Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: TopText(
                      txtFile: 'Sign Up',
                      colour: Colors.white,
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
              Buttons(colour: Color(0xff56AC81), dim: EdgeInsets.fromLTRB(0, 20, 0, 20), txt: 'Continue', col: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}


