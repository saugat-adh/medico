import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/components/Appintment_Swiper.dart';
import 'package:medico/Pages/appointments/components/HeaderButton.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HeaderButton(text: 'Your Regulars',),
          SizedBox(height: 20,),
          AppointmentSwiper(),
        ],
      ),
    );
  }
}
