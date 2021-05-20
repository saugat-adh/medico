import 'package:flutter/material.dart';
import 'package:medico/Wizards/forms.dart';
import 'package:medico/Pages/bottom_nav.dart';
import '../Wizards/buttons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LogIn extends StatefulWidget {
  static const String id = 'log_in';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController numberController = new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  var verificationCode = '';
  var isLoginScreen = true;
  var isOTPScreen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? OTPScreen() : returnLoginScreen();
  }

  Widget returnLoginScreen() {
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
                          height: 300,
                        ),
                        _buildFormContainer(),
                      ],
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Buttons(
                      txt: 'Log In',
                      click: () async {
                        if (_formKey.currentState.validate()) {
                          displaySnackBar('Verifying your Number');
                          await login();
                        }
                      },
                    )
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
        'Sign In',
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
        child: Form(
          key: _formKey,
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
                SizedBox(
                  height: 10,
                ),
                //_buildPassword(),
              ],
            ),
          ),
        ));
  }

  _buildEmail() {
    return TextFieldForm(
        txt: 'Phone Number',
        cntrl: numberController,
        types: TextInputType.phone,
        ico: Icon(
          FeatherIcons.phone,
          color: Colors.grey,
        ));
  }

  Widget OTPScreen() {
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
                        _buildTextDataOTP(),
                        SizedBox(
                          height: 200,
                        ),
                        _buildFormContainerOTP(),
                      ],
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    Buttons(
                        txt: 'Continue',
                        click: () async {
                          displaySnackBar('Verifying Your Code');
                          try {
                            await _auth
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationCode,
                                        smsCode: otpController.text.toString()))
                                .then((user) async => {
                                      //sign in was success
                                      if (user != null)
                                        {
                                          setState(() {
                                            //navigate to is
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        BotNavBar(),
                                              ),
                                              (route) => false,
                                            );
                                          })
                                        }
                                    });
                          } catch (e) {
                            displaySnackBar('OTP doesn\'t match');
                          }
                        }),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }

  _buildTextDataOTP() {
    return Positioned(
      top: 70,
      child: Text(
        'Enter OTP',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontFamily: 'Bebas',
        ),
      ),
    );
  }

  _buildFormContainerOTP() {
    return Form(
      key: _formKeyOTP,
      child: Positioned(
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
                _buildOTP(),
              ],
            ),
          )),
    );
  }

  _buildOTP() {
    return TextFieldForm(
      txt: 'OTP',
      cntrl: otpController,
      types: TextInputType.number,
    );
  }

  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text, style:TextStyle(fontFamily: 'Coda')));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future login() async {
    var phoneNumber = '+977 ' + numberController.text.trim();

    //first we will check if a user with this cell number exists
    var isValidUser = false;
    var number = numberController.text.trim();

    await _firestore
        .collection('users')
        .where('cellnumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    });

    if (isValidUser) {
      //ok, we have a valid user, now lets do otp verification
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          //auto code complete (not manually)
          _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
                if (user != null)
                  {
                    //redirect
                    setState(() {
                      isOTPScreen = false;
                    }),
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => BotNavBar(),
                      ),
                      (route) => false,
                    )
                  }
              });
        },
        verificationFailed: (FirebaseAuthException error) {
          displaySnackBar('Validation error, please try again later');
        },
        codeSent: (verificationId, [forceResendingToken]) {
          setState(() {
            verificationCode = verificationId;
            isOTPScreen = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    } else {
      //non valid user
      displaySnackBar('Number not found, please sign up first');
    }
  }
}

//986-8834622
//334224
