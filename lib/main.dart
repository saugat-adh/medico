import 'package:flutter/material.dart';

void main() {
  runApp(MedicoApp());
}

class MedicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

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
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',

                ),
              ),
            ),
            Text(
              'Medico',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',

              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'All your health needs',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'RobotoReg',

                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                'Summed up in one place',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'RobotoReg',

                ),
              ),
            ),
            // Divider(
            //   height: 2,
            //   thickness: 3,
            //   indent: 30,
            //   endIndent: 30,
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff009B15)),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
              child: ElevatedButton(
                onPressed: (){

                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xff444444)),
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      )
                  ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

