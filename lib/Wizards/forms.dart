import 'package:flutter/material.dart';

class InForm extends StatelessWidget {
  InForm({this.childNote});

  final Widget childNote;

  Widget build(BuildContext context) {
    return Container(
      child: childNote,
      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}