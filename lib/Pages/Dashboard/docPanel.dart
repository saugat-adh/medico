import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;

class DocPanel extends StatefulWidget {

  @override
  _DocPanelState createState() => _DocPanelState();
}

class _DocPanelState extends State<DocPanel> {
  final dayController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void dispose() {
    //Cleanup Controller when widget is disposed
    dateController.dispose();
    dayController.dispose();
    timeController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildAppointmentPanel(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _buildAddButton(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Divider(color: Colors.black, thickness: 2,indent: MediaQuery.of(context).size.width *0.15, endIndent: MediaQuery.of(context).size.width * 0.15,),
              Center(child: Text('Upcoming Schedules'),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _upcomingSchedules(),
            ],
          ),
        ),
      ),
    ));
  }

  _buildAppointmentPanel() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: _appointmentScheduler(),
      ),
    );
  }

  _appointmentScheduler() {
    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .collection('time')
          .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
        return Text('');
      } else {
      return Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: snapshot.data.docs.map((document) {
              return DayCard(date: document['date'],day: document['day'],time: document['time']);
            }).toList(),
          ),
        ),
      );}},
    );
  }

  _upcomingSchedules() {
    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .collection('Appointment')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Text('');
        } else {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: Column(
                children: snapshot.data.docs.map((document) {
                  return ScheduleCard(name: document['patientName'], appointmentTime: document['appointementTime'],);
                }).toList(),
              ),
            ),
          );}
      }
    );
  }

  _buildAddButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content:
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Add Appointment',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'RobotoReg',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(),
                              hintText: 'Enter Date'
                          ),
                          controller: dateController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(),
                              hintText: 'Enter time'
                          ),
                          controller: timeController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(),
                              hintText: 'Enter Day'
                          ),
                          controller: dayController,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  child: Text("Save"),
                                  onPressed: () {
                                    _addAppointment();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Appointment Added Successfully')));
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                                  ),
                                ),
                                ElevatedButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    dateController.clear();
                                    dayController.clear();
                                    timeController.clear();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.teal),
                                  ),
                                ),
                              ]
                          )
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Text('Add Appointments'),
          ),
        ),
      )
    );
  }

  _addAppointment() async{
    await _firestore..collection("doctors").doc(firebaseUser.uid).collection('time').add({
      'date' : dateController.text,
      'day' : dayController.text,
      'time' : timeController.text,
    });
    dateController.clear();
    dayController.clear();
    timeController.clear();
  }
}

class ScheduleCard extends StatelessWidget {
  ScheduleCard({this.name, this.appointmentTime});

  final String name;
  final Timestamp appointmentTime;

  @override
  Widget build(BuildContext context) {
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
              children: [
                Text(name),
                Text(appointmentTime.seconds.toString()),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DayCard extends StatelessWidget {
  DayCard({this.day, this.date, this.time});
  final String day;
  final String date;
  final String time;

  @override

  Widget build(BuildContext context) {
    return Card(
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
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(height: 10,),
            Text(
              date,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(height: 10,),
            Text(
              time,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

