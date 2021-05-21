import 'package:flutter/material.dart';

ButtonStyle popUpButton = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Color(0xff56AC81)),
);

class Buttons extends StatelessWidget {
  Buttons({@required this.txt, @required this.click});

  final String txt;
  final Function click;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: click,
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(50.0)),
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
                minHeight: 50),
            alignment: Alignment.center,
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Bebas',
                  letterSpacing: 0.7),
            ),
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
      ),
    );
  }
}
