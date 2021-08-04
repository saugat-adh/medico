import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class productModel {
  final String prduct;
  final String buyerName;
  final String buyerAddress;
  final String cellNumber;

  productModel({@required this.prduct,@required this.buyerAddress,@required this.buyerName,@required this.cellNumber});

  factory productModel.deserializeAndShow(DocumentSnapshot data) {
    print(data.data());
    return productModel(
        prduct: data['product'],
        buyerAddress: data['address'],
        buyerName: data['buyerName'],
        cellNumber: data["cellNumber"]);
  }

}