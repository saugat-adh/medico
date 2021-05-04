import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons({@required this.colour,@required this.dim, @required this.txt, this.click})  ;

  final Color colour;
  final EdgeInsets dim;
  final String txt;
  final Function click;

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
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
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

class NavIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
