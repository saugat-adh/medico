import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String category;
  final String phNumber;

  UserModel({this.category, this.phNumber});

  factory UserModel.deserialize(DocumentSnapshot doc) {
    return UserModel(category: doc['User'], phNumber: doc['phone']);
  }
}
