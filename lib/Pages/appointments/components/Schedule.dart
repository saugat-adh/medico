import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/components/Appintment_Swiper.dart';
import 'package:medico/Pages/appointments/components/HeaderButton.dart';

class Schedule extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderButton(text: 'Your Favourites',),
          SizedBox(height: 20,),
          AppointmentSwiper(),
        ],
      ),
    );
  }
}
