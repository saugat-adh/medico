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
              TopText(
                txtFile: 'Sign In',
                colour: Colors.white,
              ),
              Center(
                child: InForm(
                  childNote: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      'Form Goes Here\n'
                          'Asdf\n'
                          'ffg\n'
                          'adsdsddsfdadfasdassdadasdas\n',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Buttons(
                colour: Color(0xff56AC81),
                dim: EdgeInsets.fromLTRB(0, 20, 0, 20),
                txt: 'Sign In',
                click: (){
                  Navigator.pushReplacementNamed(context, '/dash');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}







