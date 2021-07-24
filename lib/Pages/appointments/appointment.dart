import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/components/AppointmentHeader.dart';
import 'package:medico/Pages/appointments/components/Schedule.dart';
import 'package:medico/Pages/appointments/components/categories.dart';



class Dash2 extends StatefulWidget {


  @override
  _Dash2State createState() => _Dash2State();
}

class _Dash2State extends State<Dash2> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Color(0xffF0F2F8),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  AppointmentHeader(),
                  // SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Schedule(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  CategoriesAppointment(),
                ],
              ),
            )),
      ],
    );
  }

}
