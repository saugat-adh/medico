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
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Card(
            margin: EdgeInsets.only(bottom: 20, left: 10, top: 10),
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text('You have No regulars yet'),
            ),
          ),
        ),
      )
    );
  }
}

// ...List.generate(
// 2,
// (index) => DocCard(
// text: 'Doctor Name',
// speciality: 'Speciality',
// // press: () { Navigator.push(
// //   context,
// //   MaterialPageRoute(
// //       builder: (BuildContext context) => DoctorExp()),
// // );
// // },
// ))