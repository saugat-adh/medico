import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';
import 'package:medico/constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection(userType == 'doctors' ? 'doctors' : 'patients')
          .doc(firebaseUser.uid)
          .collection('docAppointment')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
    return Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(
    title: Text("Notification"),
    automaticallyImplyLeading: true,
    backgroundColor: Colors.green),
    );
    } else {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text("Notification"),
            automaticallyImplyLeading: true,
            backgroundColor: Colors.green),
        body: SingleChildScrollView(
          child: Column(
            children: snapshot.data.docs.map((document){
              String date = "00";
              String month = "34";
              String year = "2002";
              String timeHour = "34";
              String timeSec = "34:";
              String patientName = "exapmle";
              String docDatabase = document['appointmentTime'];
              date = docDatabase.split(" ")[0];
              month = docDatabase.split(" ")[1];
              year = docDatabase.split(" ")[2];
              String laterHalf = docDatabase.split(" ")[3];
              timeHour = laterHalf.split(":")[0];
              timeSec = laterHalf.split(":")[1];

              return DocScheduleCard(id: document.id, time: "$timeHour:$timeSec ${amPm(timeHour)}", date: "${date.split(" ")[0]} $month ", year: year);
        }).toList(),
          ),
        ),
      );
    }
      }
    );
  }

  amPm(String hour) {
    if (int.parse(hour) >= 12) {
      return "PM";
    } else {
      return "AM";
    }
  }
}

class DocScheduleCard extends StatelessWidget {
  DocScheduleCard({this.id, this.time, this.year, this.date});

  final String id;
  final String time;
  final String year;
  final String date;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection( 'doctors').where(FieldPath.documentId, isEqualTo: id).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: snapshot.data.docs.map((document){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  DoctorExp(document)),
                        );
                      },
                      child: Column(
                        children: [
                          Text(document['First name'] + ' ' + document['Last name']),
                          SizedBox(height: 20,),
                          Text(document['speciality']),
                          SizedBox(height: 20,),
                          Text(date + ' ' + year),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Time: '),
                              Text(time),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
