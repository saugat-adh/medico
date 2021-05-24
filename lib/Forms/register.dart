import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../Wizards/buttons.dart';
import '../Wizards/forms.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import '../Components/snackbar.dart';
import '../methods/register_method.dart';



class SignUp extends StatefulWidget {
  static const String id = 'sign_up';


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController fnameController = new TextEditingController();
  final TextEditingController lnameController = new TextEditingController();
  final TextEditingController cellnumberController =
      new TextEditingController();
  final TextEditingController otpController = new TextEditingController();
  final TextEditingController nmcIdController = new TextEditingController();
  final TextEditingController specialityController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    fnameController.dispose();
    lnameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return registerScreen();
  }

  Widget registerScreen() {
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
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              body: ModalProgressHUD(
                inAsyncCall: showSpinner,
                child: SingleChildScrollView(
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
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                          //_buildFormContainer(),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(children: [
                            _buildFirstName(),
                            SizedBox(
                              height: 20,
                            ),
                            _buildLastName(),
                            SizedBox(
                              height: 20,
                            ),
                            _buildPhoneNumber(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Are you a doctor?",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.black),
                                    value: isUserADoctor,
                                    onChanged: (value) {
                                      setState(() {
                                        isUserADoctor = value;
                                        print(isUserADoctor);
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            isUserADoctor
                                ? Column(
                                    children: [
                                      _buildNMCId(),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      _speciality(),
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.05,
                                      ),
                                    ],
                                  )
                                : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),

                          ]),
                        ),
                      ),
                      Buttons(
                        txt: 'Continue',
                        click: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a loading Snackbar
                            displaySnackBar('Verifying Your Number', _scaffoldKey);
                            await signUp(cellnumberController, fnameController, lnameController, nmcIdController, specialityController, _scaffoldKey, this.context);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
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
      height: MediaQuery.of(context).size.width * 0.4,
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
      top: MediaQuery.of(context).size.height * 0.06,
      child: Text(
        'Sign Up',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: 'Bebas',
        ),
      ),
    );
  }

  _buildPhoneNumber() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.phone),
      labelTxt: 'Phone Number',
      txt: 'Enter Your Phone Number',
      cntrl: cellnumberController,
      types: TextInputType.phone,
    );
  }

  _buildNMCId() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'NMC ID',
      txt: 'Enter Your NMC Id',
      cntrl: nmcIdController,
      types: TextInputType.text,
    );
  }

  _speciality() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'Speciality',
      txt: 'Enter Your Speciality',
      cntrl: specialityController,
      types: TextInputType.text,
    );
  }

  _buildFirstName() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'First Name',
      txt: 'Enter Your First Name',
      cntrl: fnameController,
      types: TextInputType.text,
    );
  }

  _buildLastName() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'Last Name',
      txt: 'Enter Your Last Name',
      cntrl: lnameController,
      types: TextInputType.text,
    );
  }
}
