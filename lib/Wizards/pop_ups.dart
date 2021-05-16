import 'package:flutter/material.dart';
import 'buttons.dart';

class BuildPopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: new Container(
        child: Text(
          'Do You really want to Log Out?'
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: popUpButton ,
          child: const Text('No'),
        ),
        new TextButton(
          onPressed: (){
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
          style: popUpButton,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}