import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Forms/info_form.dart';
import '../Wizards/buttons.dart';
import '../Wizards/forms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class SignUp extends StatefulWidget {
  static const String id = 'sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController FnameController = new TextEditingController();
  final TextEditingController LnameController = new TextEditingController();
  final TextEditingController cellnumberController =
      new TextEditingController();
  final TextEditingController otpController = new TextEditingController();

  var verificationCode = '';
  var isRegister = true;
  var isOTPScreen = false;

  bool showSpinner = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    FnameController.dispose();
    LnameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isOTPScreen ? OTPScreen() : registerScreen();
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
                            height: 200,
                          ),
                          //_buildFormContainer(),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          child: Column(children :[_buildFirstName(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildLastName(),
                          SizedBox(
                            height: 20,
                          ),
                          _buildPhoneNumber(),]),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Buttons(
                        txt: 'Continue',
                        click: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, we want to show a loading Snackbar
                            displaySnackBar('Verifying Your Number');
                            await signUp();
                          }
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

  _buildPhoneNumber() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.phone),
      labelTxt: 'Phone Number',
      txt: 'Enter Your Phone Number',
      cntrl: cellnumberController,
      types: TextInputType.phone,
    );
  }

  _buildFirstName() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'First Name',
        txt: 'Enter Your First Name',
        cntrl: FnameController,
        types: TextInputType.text,
        );
  }

  _buildLastName() {
    return TextFieldForm(
      ico: Icon(FeatherIcons.user),
      labelTxt: 'Last Name',
        txt: 'Enter Your Last Name',
        cntrl: LnameController,
        types: TextInputType.text,
        );
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
                          _buildTextDataOTP(),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                      _buildOTP(),
                      SizedBox(
                        height: 50.0,
                      ),
                      Buttons(
                          txt: 'Continue',
                          click: () async {
                            setState(() {
                              showSpinner = true;
                            });
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
                                            //store registration details in firestore database
                                            await _firestore
                                                .collection('users')
                                                .doc(_auth.currentUser.uid)
                                                .set({
                                              'First name': FnameController.text.trim(),
                                              'Last name': LnameController.text.trim(),
                                              'cellnumber': cellnumberController
                                                  .text
                                                  .trim(),
                                            }, SetOptions(merge: true)).then(
                                                    (value) => {
                                                          //then move to authorised area
                                                        }),
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    InfoForm(),
                                              ),
                                              (route) => true,
                                            )
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

  _buildOTP() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        child: TextFieldForm(
          ico: Icon(FeatherIcons.key),
          labelTxt: 'OTP',
          txt: 'Enter Your OTP',
          cntrl: otpController,
          types: TextInputType.number,
        ),
      ),
    );
  }

  displaySnackBar(text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future signUp() async {
    var isValidUser = false;
    var number = cellnumberController.text.trim();

    await _firestore
        .collection('users')
        .where('cellnumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    });

    if(!isValidUser){
      debugPrint('Gideon test 1');
      var phoneNumber = '+977 ' + cellnumberController.text.toString();
      debugPrint('Gideon test 2');
      var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          debugPrint('Gideon test 3');
          //auto code complete (not manually)
          _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
                if (user != null)
                  {
                    //store registration details in firestore database
                    await _firestore
                        .collection('users')
                        .doc(_auth.currentUser.uid)
                        .set({
                          'First name': FnameController.text.trim(),
                          'Last name': LnameController.text.trim(),
                          'cellnumber': cellnumberController.text.trim()
                        }, SetOptions(merge: true))
                        .then((value) => {
                              //then move to authorised area
                              setState(() {
                                showSpinner = false;
                                //navigate to is
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        InfoForm(),
                                  ),
                                  (route) => false,
                                );
                              })
                            })
                        .catchError((onError) => {
                              debugPrint('Error saving user to db.' +
                                  onError.toString())
                            })
                  }
              });
          debugPrint('Gideon test 4');
        },
        verificationFailed: (FirebaseAuthException error) {
          debugPrint('Gideon test 5' + error.message);
        },
        codeSent: (verificationId, [forceResendingToken]) {
          debugPrint('Gideon test 6');
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Gideon test 7');
          setState(() {
            verificationCode = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
      debugPrint('Gideon test 7');
      await verifyPhoneNumber;
      debugPrint('Gideon test 8');
      isOTPScreen = true;
      isRegister = false;
    } else {
      displaySnackBar('Already Have an account');
    }
    setState(() {
      showSpinner = false;
    });

  }
}