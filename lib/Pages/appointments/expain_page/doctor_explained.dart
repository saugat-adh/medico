import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/appointments/book_page/book_page.dart';
import 'package:medico/Pages/appointments/expain_page/components/body_part.dart';
import 'package:medico/Pages/appointments/expain_page/components/head_part.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DoctorExp extends StatefulWidget {
  static const String id = 'doctor_explained';
  final QueryDocumentSnapshot docs;

  const DoctorExp(this.docs);

  @override
  _DoctorExpState createState() => _DoctorExpState();
}

class _DoctorExpState extends State<DoctorExp> {

  void containmentCheck() async{
    final firebaseUser = _auth.currentUser;

    if (firebaseUser != null)
      await _firestore
        .collection(userType)
        .doc(firebaseUser.uid)
        .collection('regulars').where('UID', isEqualTo: widget.docs.id).get().then((value) async{
      if (value.docs.length > 0){
        containment = true;
        print('a');
      } else { containment = false; print('b');}
    });
  }

  @override
  void initState() {
    super.initState();
    containmentCheck();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xfff7f7fc),
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(),
                HeadPart(fName: widget.docs['First name'],lName: widget.docs['Last name'],speciality: widget.docs['speciality'],imageUrl: widget.docs['imageURl'],),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                BodyPart(address: widget.docs['address'], email: widget.docs['email'], number: widget.docs['cellnumber'], id: widget.docs.id,),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 3,
                  blurRadius: 10,
                )
              ],
              color: Colors.white,
            ),
            height: 80,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff0118B5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  width: MediaQuery.of(context).size.width - 90,
                  child: Center(
                      child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BookPage(widget.docs)),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Make appointment',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Muli',
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                        Icon(
                          FeatherIcons.plus,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
          )),
    );
  }

  _buildBackButton() {
    return IconButton(
      icon: Icon(FeatherIcons.arrowLeft),
      color: Colors.black,
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
    );
  }
}
