import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'Wizards/buttons.dart';

class SignUp extends StatefulWidget {
  static String id = 'sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      _buildBackgroundCover(),
                      _buildBackIcon(),
                      _buildTextData(),
                      _buildFormContainer(),
                    ],
                  ),
                  SizedBox(
                    height: 130.0,
                  ),
                  Buttons(
                    txt: 'Continue',
                    click: (){

                    },
                  )
                ],
              ),
            )),
      ]),
    );
  }

  _buildBackIcon() {
    return Positioned(
        left: -13,
        child: IconButton(
          icon: Icon(FeatherIcons.arrowLeft),
          color: Colors.white,
          constraints: BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
            minHeight: 80,
            minWidth: 80,
          ),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ));
  }

  _buildBackgroundCover() {
    return Container(
      height: 260.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.green,
            Colors.teal,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          //bottomRight: Radius.circular(40)
        ),
      ),
    );
  }

  _buildTextData() {
    return Positioned(
      top: 70,
      child: Text(
        'Sign Up',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: 'Bebas',
        ),
      ),
    );
  }

  _buildFormContainer() {
    return Positioned(
        bottom: -100,
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width - 60,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ],
          ),
          child: Text('Form Goes here'),
        ));
  }
}
