import 'package:flutter/material.dart';
import 'package:medico/Pages/bottom_nav.dart';
import 'package:medico/Forms/info_form.dart';
import 'Pages/home_page.dart';
import 'Forms/log_in.dart';
import 'Forms/register.dart';


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
        InfoForm.id : (context) => InfoForm(),
      },
    );
  }
}

// riwimi007@gmail.com
// riwimi123



