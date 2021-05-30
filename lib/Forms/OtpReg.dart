import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Wizards/forms.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../constants.dart';
import 'info_form.dart';
import '../Wizards/buttons.dart';
import '../Components/snackbar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class OtpScreenReg extends StatefulWidget {
  final cellnumberController;
  final fnameController;
  final lnameController;
  final nmcIdController;
  final speciality;

  const OtpScreenReg(this.cellnumberController, this.fnameController,
      this.lnameController, this.nmcIdController, this.speciality);

  @override
  _OtpScreenRegState createState() => _OtpScreenRegState();
}

class _OtpScreenRegState extends State<OtpScreenReg> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showSpinner = false;

  final TextEditingController otpController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return otpScreen();
  }

  Widget otpScreen() {
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
                            height: MediaQuery.of(context).size.height * 0.28,
                          ),
                        ],
                      ),
                      _buildOTP(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Buttons(
                          txt: 'Continue',
                          click: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            displaySnackBar(
                                'Verifying Your Code', _scaffoldKey);
                            try {
                              await _auth
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationCode,
                                          smsCode:
                                              otpController.text.toString()))
                                  .then((user) async => {
                                        //sign in was success
                                        if (user != null)
                                          {
                                            //store registration details in firestore database
                                            _commonUserDB(),
                                            if (isUserADoctor)
                                              {
                                                await _firestore
                                                    .collection('doctors')
                                                    .doc(_auth.currentUser.uid)
                                                    .set(
                                                        {
                                                      'First name': widget
                                                          .fnameController.text
                                                          .trim(),
                                                      'Last name': widget
                                                          .lnameController.text
                                                          .trim(),
                                                      'cellnumber': widget
                                                          .cellnumberController
                                                          .text
                                                          .trim(),
                                                      "nmcID": widget
                                                          .nmcIdController.text
                                                          .trim(),
                                                      "speciality":
                                                          widget.speciality,
                                                      "address": "",
                                                      "email": "",
                                                      "gender": "",
                                                      "height": "",
                                                      "weight": "",
                                                    },
                                                        SetOptions(
                                                            merge: true)).then(
                                                        (value) => {
                                                              //then move to authorised area
                                                            }),
                                              }
                                            else
                                              {
                                                await _firestore
                                                    .collection('patients')
                                                    .doc(_auth.currentUser.uid)
                                                    .set(
                                                        {
                                                      'First name': widget
                                                          .fnameController.text
                                                          .trim(),
                                                      'Last name': widget
                                                          .lnameController.text
                                                          .trim(),
                                                      'cellnumber': widget
                                                          .cellnumberController
                                                          .text
                                                          .trim(),
                                                      "DOB": DateTime.now(),
                                                      "address": "",
                                                      "email": "",
                                                      "gender": "",
                                                      "height": "",
                                                      "weight": "",
                                                    },
                                                        SetOptions(
                                                            merge: true)).then(
                                                        (value) => {
                                                              //then move to authorised area
                                                            }),
                                              },

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    InfoForm(
                                                        category: isUserADoctor
                                                            ? "doctors"
                                                            : "patients",
                                                        auth: _auth
                                                            .currentUser.uid),
                                              ),
                                              (route) => false,
                                            )
                                          }
                                      });
                            } catch (e) {
                              displaySnackBar(
                                  'OTP doesn\'t match', _scaffoldKey);
                              setState(() {
                                showSpinner = false;
                              });
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
      top: MediaQuery.of(context).size.height * 0.06,
      child: Text(
        'Enter OTP',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.16,
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

  _commonUserDB() async {
    await _firestore.collection('AllUsers').doc(_auth.currentUser.uid).set({
      "User": isUserADoctor ? "doctors" : "patients",
      "phone": widget.cellnumberController.text.trim()
    });
  }
}
