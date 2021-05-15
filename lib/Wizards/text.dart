import 'dart:ffi';
import 'package:flutter/material.dart';

class TopText extends StatelessWidget {
  TopText({this.txtFile, this.colour});

  final String txtFile;
  final Color colour;

  Widget build(BuildContext context) {
    return Text(
      txtFile,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: colour,
      ),
    );
  }
}

class MidText extends StatelessWidget {
  MidText({this.txtFile, this.dime, this.colour});
  final String txtFile;
  final EdgeInsets dime;
  final Color colour;

  Widget build(BuildContext context) {
    return Container(
      margin: dime,
      child: Text(
        txtFile,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'RobotoReg',
          color: colour,
        ),
      ),
    );
  }
}


