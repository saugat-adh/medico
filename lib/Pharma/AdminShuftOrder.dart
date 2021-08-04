import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/models/productModel.dart';
class AdminShiftOrders extends StatefulWidget {


  @override
  _AdminShiftOrdersState createState() => _AdminShiftOrdersState();
}

class _AdminShiftOrdersState extends State<AdminShiftOrders> {
  Stream<List<productModel>> getNotifications() {
    final snapshots = FirebaseFirestore.instance.collection('StoreAdmin')
        .doc(FirebaseAuth.instance.currentUser.uid).collection('item')
        .snapshots();

    return snapshots.map((event) => event.docs
        .map((snapshot) => productModel.deserializeAndShow(snapshot))
        .toList());
  }
  buildNotification(BuildContext context) {
    return StreamBuilder<List<productModel>>(
        stream: getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notifications = snapshot.data;
            if (notifications.isNotEmpty) {
              final displayNotification = notifications.map((e) {
                return Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: ListTile(
                      title: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: e.buyerName,

                                  style: TextStyle( color:Colors.black, fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: " ${e.prduct}",
                                  style: TextStyle(color:Colors.black,)
                                ),
                              ]),
                        ),

                      subtitle: Text(
                        "Address : ${e.buyerAddress} - ${e.cellNumber}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w100),
                      ),

                    ),
                  ),
                );
              }).toList();

              return ListView.builder(

                itemCount: displayNotification.length,
                itemBuilder: (context, int index) {
                  return displayNotification[index];
                },
              );
            }

            return Center(
                child: Text(
                  "No Activity",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ));
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Activity"),
      ),
      body: buildNotification(context),
    );
  }
}
