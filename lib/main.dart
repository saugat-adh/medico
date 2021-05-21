import 'package:flutter/material.dart';
import 'package:medico/Pages/bottom_nav.dart';
import 'package:medico/Forms/info_form.dart';
import 'Pages/home_page.dart';
import 'Forms/log_in.dart';
import 'Forms/register.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MedicoApp());
}

class MedicoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primarySwatch: Colors.green,
          // ),
        home: HomePage(),
        routes: {
          HomePage.id : (context) => HomePage(),
          LogIn.id : (context) => LogIn(),
          SignUp.id : (context) => SignUp(),
          BotNavBar.id : (context) => BotNavBar(),
          InfoForm.id : (context) => InfoForm(),
        },
      );}
    );
  }
}

// riwimi007@gmail.com
// riwimi123



