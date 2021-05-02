import 'package:flutter/material.dart';
import 'home_page.dart';
import 'log_in.dart';
import 'register.dart';


void main() {
  runApp(MedicoApp());
}

class MedicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/signIn': (context) => LogIn(),
        '/signUp': (context) => SignUp(),
      },
    );
  }
}



