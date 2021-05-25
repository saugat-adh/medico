import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/components/Appintment_Swiper.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Regulars'),
                Text('See all'),
              ],
            ),

          ),
          SizedBox(height: 20,),
          AppointmentSwiper(),
        ],
      ),
    );
  }
}
