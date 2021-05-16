import 'package:flutter/material.dart';
import 'Wizards/buttons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
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
                      SizedBox(height: 300,),
                      _buildFormContainer(),
                    ],
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Buttons(
                    txt: 'Log In',
                    click: (){
                      Navigator.pushReplacementNamed(context, '/dash');
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
        'Sign In',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  _buildFormContainer() {
    return Positioned(
        bottom: -50,
        child: Container(
          //height: 300,
          width: MediaQuery.of(context).size.width - 60,
          padding: EdgeInsets.all(30),
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
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildEmail(),
              SizedBox(height: 10,),
              _buildPassword(),
            ],
          ),
        ));
  }

  _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          icon: Icon(FeatherIcons.user, color: Colors.grey,),
          contentPadding: EdgeInsets.all(10),
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide.none,
          )
      ),
    );
  }

  _buildPassword(){
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        icon: Icon(FeatherIcons.key, color: Colors.grey,),
        contentPadding: EdgeInsets.all(10),
        hintText: 'Password',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}







