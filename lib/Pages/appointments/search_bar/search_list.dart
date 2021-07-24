import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/components/doc_card.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;

class DocListSearch extends StatelessWidget {
  DocListSearch({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .where('First name', isEqualTo: title)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Container(child: Text('No results found'))),
            ],
          );
        } else {
          return Column(
            children: snapshot.data.docs.map((document) {
              if (document.id != firebaseUser.uid) {
                return DocCard(
                  docx: document,
                  docUid: document.id,
                  imageUrl: document['ImgUrl'],
                  text: document['First name'] + " " + document['Last name'],
                  speciality: document['speciality'],
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DoctorExp(document)),
                    );
                  },
                );
              } else {
                return Center(child: Text(''));
              }
            }).toList(),
          );
        }
      },
    );
  }
}
