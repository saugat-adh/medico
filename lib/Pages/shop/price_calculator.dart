
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

price() {
  _firestore.collection(userType).doc(firebaseUser.uid).collection('cart').get().then(
          (querySnapshot) {
        total_price = 0;
        querySnapshot.docs.forEach((result) {
          _firestore.collection('products').where(FieldPath.documentId, isEqualTo: result['UID']).get().then((querySnapshot){
            querySnapshot.docs.forEach((document) {
              total_price = total_price + int.parse(document['Price']) * int.parse(result['quanitiy']);
            });
          });
        });
      });
}