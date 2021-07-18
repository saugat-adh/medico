import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medico/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var temp;
int count = 0;

List<String> days = [
  'Tue',
];

List<String> time = ['1:00', '9:00', '12:00', '2:00'];

class HeadPartBook extends StatelessWidget {
  HeadPartBook({this.speciality, this.name, this.imageUrl, this.docx});

  final String name;
  final String speciality;
  final String imageUrl;

  final QueryDocumentSnapshot docx;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: _firestore
        .collection('doctors')
        .doc(docx.id)
        .collection('time')
        .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Text('');
        } else {
          return Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Muli',
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                      Text(
                        speciality,
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Muli',
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Appointment',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: snapshot.data.docs.map((document) {
                        return DateContainer(date: document['date'],day: document['day'],time: document['time']);
                        }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class DateContainer extends StatelessWidget {
  DateContainer({this.date, this.day, this.time});

  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                day,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.037),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                date,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                time,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeContainer extends StatelessWidget {
  TimeContainer({this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          time,
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Muli',
              fontSize: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
    );
  }
}

