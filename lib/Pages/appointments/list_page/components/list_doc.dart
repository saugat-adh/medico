import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';

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

class DocCard extends StatelessWidget {
  DocCard({this.text, this.press, this.speciality});

  final String text;
  final Function press;
  final String speciality;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.height * 0.22,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 30,
                      color: Color(0xffe5e5e5),
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage('images/tmp.jpg'),
                            fit: BoxFit.fill,
                          )
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Column(
                        children: [
                          Text(
                            text,
                            style:
                                TextStyle(color: Colors.black, fontFamily: 'Bebas', fontSize: MediaQuery.of(context).size.width * 0.063),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            speciality,
                            style:
                            TextStyle(color: Colors.grey, fontFamily: 'Muli', fontSize: MediaQuery.of(context).size.width * 0.04),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                          Row(
                            children: [
                              ...List.generate(5, (index) => Icon(FeatherIcons.star, size: MediaQuery.of(context).size.width * 0.04,color: Colors.amber,)),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                              Text(
                                '4.5',
                                style:
                                TextStyle(color: Colors.grey, fontFamily: 'Muli', fontSize: MediaQuery.of(context).size.width * 0.04),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Text(
                            '120 Reviews',
                            style:
                            TextStyle(color: Colors.grey, fontFamily: 'Muli', fontSize: MediaQuery.of(context).size.width * 0.04),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
