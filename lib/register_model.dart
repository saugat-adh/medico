import 'package:flutter/material.dart';
import 'package:medico/Components/snackbar.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future signUp(cellnumberController, skey) async {
  var isValidUser = false;
  var number = cellnumberController.text.trim();

  await _firestore
      .collection('patients',)
      .where('cellnumber', isEqualTo: number)
      .get()
      .then((result) {
    if (result.docs.length > 0) {
      isValidUser = true;
    }
  });

  await _firestore
      .collection('doctors',)
      .where('cellnumber', isEqualTo: number)
      .get()
      .then((result) {
    if (result.docs.length > 0) {
      isValidUser = true;
    }
  });

  if (!isValidUser) {
    debugPrint('Gideon test 1');
    var phoneNumber = '+977 ' + cellnumberController.text.toString();
    debugPrint('Gideon test 2');
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Gideon test 3');
      },
      verificationFailed: (FirebaseAuthException error) {
        debugPrint('Gideon test 4' + error.message);
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('Gideon test 5');
          verificationCode = verificationId;

      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Gideon test 6');
          verificationCode = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint('Gideon test 7');
    await verifyPhoneNumber;
    debugPrint('Gideon test 8');
    isRegister = false;
    showSpinner = false;
    return;
  } else {
    displaySnackBar('Already Have an account', skey);
    return;
  }
    showSpinner = false;
}