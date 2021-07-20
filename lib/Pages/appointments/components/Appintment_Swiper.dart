import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doc_card.dart';
import '../expain_page/doctor_explained.dart';
import '../../../constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AppointmentSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (userType == 'doctors') {
      return StreamBuilder(
          stream: _firestore
              .collection('doctors')
              .doc(firebaseUser.uid)
              .collection('regulars')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return Container(
                color: Color(0xffF0F2F8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    margin: EdgeInsets.only(
                        bottom: 20, left: 10, top: 10, right: 10),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text('You have No regulars yet'),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                  color: Color(0xffF0F2F8),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data.docs.map((document) {
                              return StreamBuilder(
                                stream: _firestore
                                    .collection('doctors')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> abc) {
                                  if (!abc.hasData || abc.data.docs.isEmpty) {
                                    return Container();
                                  } else {
                                    return Row(
                                      children: abc.data.docs.map((xyz) {
                                        if (document['UID'] == xyz.id) {
                                          return DocCard(
                                            docx: xyz,
                                            docUid: xyz.id,
                                            imageUrl: xyz['imageURl'],
                                            text: xyz['First name'] +
                                                " " +
                                                xyz['Last name'],
                                            speciality: xyz['speciality'],
                                            press: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DoctorExp(xyz)),
                                              );
                                            },
                                          );
                                        } else {
                                          return Text('');
                                        }
                                      }).toList(),
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        )),
                  ));
            }
          });
    } else if (userType == 'patients') {
      return StreamBuilder(
          stream: _firestore
              .collection('patients')
              .doc(firebaseUser.uid)
              .collection('regulars')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return Container(
                color: Color(0xffF0F2F8),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.28,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    margin: EdgeInsets.only(
                        bottom: 20, left: 10, top: 10, right: 10),
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text('You have No regulars yet'),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                  color: Color(0xffF0F2F8),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Center(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data.docs.map((document) {
                              return StreamBuilder(
                                stream: _firestore
                                    .collection('doctors')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> abc) {
                                  if (!abc.hasData || abc.data.docs.isEmpty) {
                                    return Container();
                                  } else {
                                    return Row(
                                      children: abc.data.docs.map((xyz) {
                                        if (document['UID'] == xyz.id) {
                                          return DocCard(
                                            docx: xyz,
                                            docUid: xyz.id,
                                            imageUrl: xyz['imageURl'],
                                            text: xyz['First name'] +
                                                " " +
                                                xyz['Last name'],
                                            speciality: xyz['speciality'],
                                            press: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DoctorExp(xyz)),
                                              );
                                            },
                                          );
                                        } else {
                                          return Text('');
                                        }
                                      }).toList(),
                                    );
                                  }
                                },
                              );
                            }).toList(),
                          ),
                        )),
                  ));
            }
          });
    } else {
      return Container();
    }
  }
}
