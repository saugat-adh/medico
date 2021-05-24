import 'package:flutter/material.dart';
import 'package:medico/Forms/OtpLogin.dart';
import 'models/userModel.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Pages/bottom_nav.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future login(numberController, context) async {
  String type = '';
  var phoneNumber = '+977 ' + numberController.text.trim();

  //first we will check if a user with this cell number exists
  var isValidUser = false;
  var number = numberController.text.trim();

  QuerySnapshot snapshot = await _firestore.collection("AllUsers").get();
  snapshot.docs.forEach((user) {
    UserModel userdata = UserModel.deserialize(user);
    if (userdata.phNumber == numberController.text.trim()) {
      type = userdata.category;
    }
  });

  if (type.isEmpty) {
    print('Number not found, please sign up first');
    return;
  } else {
    await _firestore
        .collection(type)
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
                    showSpinner = false,
                    isOTPScreen = false,
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
          print('Validation error, please try again later');
          return;
        },
        codeSent: (verificationId, [forceResendingToken]) {
          verificationCode = verificationId;
          showSpinner = false;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => OtpScreenLogin(),
            ),
            (route) => false,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: Duration(seconds: 60),
      );
      await verifyPhoneNumber;
    } else {
      print("yeta pugyo");
      showSpinner = false;
      print('Number not found, please sign up first');
      return;
      // non valid user
    }
  }
}
