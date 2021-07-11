import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          title: Text("Notification"),
          automaticallyImplyLeading: true,
          backgroundColor: Colors.green),
    );
  }
}
