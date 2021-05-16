import 'package:flutter/material.dart';
import 'buttons.dart';

class BuildPopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Do you really want to Sign Out?"),
        ],
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