import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/constants.dart';
import 'package:readmore/readmore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BodyPart extends StatelessWidget {
  BodyPart({this.number, this.address, this.email, this.id});

  final String number;
  final String address;
  final String email;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biography',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(
                height: 10,
              ),
              ReadMoreText(
                'Singing is the act of producing musical sounds with the voice. A person who sings is called a singer or vocalist (in jazz and popular music). Singers perform music (arias, recitatives, songs, etc.) that can be sung with or without accompaniment by musical instruments. Singing is often done in an ensemble of musicians, such as a choir of singers or a band of instrumentalists.',
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.039,
                    fontWeight: FontWeight.bold),
                lessStyle: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.039,
                    fontWeight: FontWeight.bold),
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.039,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Contact',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    FeatherIcons.mail,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AutoSizeText(
                    email,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    FeatherIcons.phone,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '+977' + number,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(
                    FeatherIcons.map,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    address,
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Leave a rating',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Text(
              //   'Reviews',
              //   style: TextStyle(
              //       fontFamily: 'Muli',
              //       fontWeight: FontWeight.bold,
              //       fontSize: MediaQuery.of(context).size.width * 0.05),
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                ),
                child:
                    IconButton(onPressed: () {
                        addReg(id);
                    },
                        icon:  Icon(FeatherIcons.plusCircle) ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future addReg(docId) async{
    final firebaseUser = _auth.currentUser;
    String user;

    if (firebaseUser != null)
      await _firestore
        .collection('AllUsers')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      user = documentSnapshot.get('User');
    }).catchError((e) {
      print(e);
    });

    if (firebaseUser != null)
    await _firestore
        .collection(user)
        .doc(firebaseUser.uid)
        .collection('regulars').where('UID', isEqualTo: id).get().then((value) async{
          if (value.docs.length > 0){
            return;
          } else {
            if (firebaseUser != null && user == 'patients')
              await _firestore
                .collection('patients')
                .doc(firebaseUser.uid)
                .collection('regulars')
                .add({
              "UID" : docId,
            });

            if (firebaseUser != null && user == 'doctors')
              await _firestore
                .collection('doctors')
                .doc(firebaseUser.uid)
                .collection('regulars')
                .add({
              "UID" : docId,
            });
          }
    });
  }
}
