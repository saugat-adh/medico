import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: TopText(
                txtFile: 'Welcome To',
              )
            ),
            TopText(
              txtFile: 'Medico',
            ),
            MidText(
              txtFile: 'All your health needs',
              dime: EdgeInsets.fromLTRB(0, 20, 0, 0),
            ),
            MidText(
              txtFile: 'Summed up in one place',
            ),
            Buttons(
              colour: Color(0xff009B15),
              dim: EdgeInsets.fromLTRB(0, 200, 0, 0),
            ),
            Buttons(
              colour: Color(0xff444444),
              dim: EdgeInsets.fromLTRB(0, 20, 0, 40),
            )
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Buttons({@required this.colour,@required this.dim})  ;

  final Color colour;
  final EdgeInsets dim;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: dim,
      width: 350,
      child: ElevatedButton(
        onPressed: (){

        },
        child: Text(
          'Log In',
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
  TopText({this.txtFile});

  final String txtFile;

  Widget build(BuildContext context) {
    return Text(
      txtFile,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',

      ),
    );
  }
}

class MidText extends StatelessWidget {
  MidText({this.txtFile, this.dime});
  final String txtFile;
  final EdgeInsets dime;

  Widget build(BuildContext context) {
    return Container(
      margin: dime,
      child: Text(
        txtFile,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'RobotoReg',

        ),
      ),
    );
  }
}


