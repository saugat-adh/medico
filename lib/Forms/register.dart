import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Forms/info_form.dart';
import '../Wizards/buttons.dart';
import '../Wizards/forms.dart';

class SignUp extends StatefulWidget {
  static const String id = 'sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
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
                        SizedBox(
                          height: 400,
                        ),
                        _buildFormContainer(),

                      ],
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Buttons(
                      txt: 'Continue',
                      click: () {
                        Navigator.pushNamed(context, InfoForm.id);
                      },
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              )),
        ]),
      ),
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
              _buildPhoneNumber(),
              SizedBox(
                height: 10,
              ),
              _buildDOB(),
              SizedBox(
                height: 10,
              ),
              _buildPassword(),
              SizedBox(
                height: 10,
              ),
              _buildConfirmPassword(),

            ],
          ),
        ));
  }


  _buildPassword() {
    return TextFieldForm(
        txt: 'Password',
        pass: true,
        types: TextInputType.visiblePassword,
        ico: Icon(
          FeatherIcons.key,
          color: Colors.grey,
        ));
  }
  _buildPhoneNumber() {
    return TextFieldForm(
      txt: 'Phone Number',
      ico: Icon(
        FeatherIcons.phone,
        color: Colors.grey,
      ),
      types: TextInputType.phone,
    );
  }
  _buildDOB() {
    return TextFieldForm(
      txt: 'Date Of Birth',
      ico: Icon(
        FeatherIcons.calendar,
        color: Colors.grey,
      ),
      types: TextInputType.datetime,
    );
  }
  _buildConfirmPassword() {
    return TextFieldForm(
        txt: 'Confirm Password',
        pass: true,
        types: TextInputType.visiblePassword,
        ico: Icon(
          FeatherIcons.key,
          color: Colors.grey,
        ));
  }
}
