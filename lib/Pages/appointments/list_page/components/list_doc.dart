import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';
import '../../components/doc_card.dart';

class DocList extends StatelessWidget {
  const DocList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ...List.generate(
              5,
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
    );
  }
}

