import 'package:flutter/material.dart';

ButtonStyle popUpButton = ButtonStyle(
  foregroundColor: MaterialStateProperty.all<Color>(Color(0xff56AC81)),
);

class Buttons extends StatelessWidget {
  Buttons({@required this.colour,@required this.dim, @required this.txt, this.click, this.col})  ;

  final Color colour;
  final EdgeInsets dim;
  final String txt;
  final Function click;
  final Color col;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: dim,
      width: 350,
      child: ElevatedButton(
        onPressed: click,
        child: Text(
          txt,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            color: col,
          ),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(BorderSide(width: 2.0, color: Color(0xffECECEC),)),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(colour),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
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