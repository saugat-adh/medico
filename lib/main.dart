import 'package:flutter/material.dart';
import 'package:medico/bottom_nav.dart';
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
      initialRoute: HomePage.id,
      routes: {
        HomePage.id : (context) => HomePage(),
        LogIn.id : (context) => LogIn(),
        SignUp.id : (context) => SignUp(),
        BotNavBar.id : (context) => BotNavBar(),
      },
    );
  }
}



