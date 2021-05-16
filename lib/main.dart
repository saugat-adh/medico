import 'package:flutter/material.dart';
import 'package:medico/bottom_nav.dart';
import 'package:medico/dashboard.dart';
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
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/signIn': (context) => LogIn(),
        '/signUp': (context) => SignUp(),
        '/dash': (context) => BotNavBar(),
      },
    );
  }
}



