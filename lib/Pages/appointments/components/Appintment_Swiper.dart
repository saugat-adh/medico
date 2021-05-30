import 'package:flutter/material.dart';
import '../components/doc_card.dart';
import '../expain_page/doctor_explained.dart';

class AppointmentSwiper extends StatelessWidget {
  const AppointmentSwiper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF0F2F8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.28,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
                2,
                    (index) => DocCard(
                  text: 'Doctor Name',
                  speciality: 'Speciality',
                  press: () { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => DoctorExp()),
                  );
                  },
                ))
          ],
        ),
      )
    );
  }
}
