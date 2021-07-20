import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var temp;
int count = 0;

List<String> days = [
  'Tue',
];

List<String> time = ['1:00', '9:00', '12:00', '2:00'];

class HeadPartBook extends StatefulWidget {
  HeadPartBook({this.speciality, this.name, this.imageUrl, this.docx});

  final String name;
  final String speciality;
  final String imageUrl;

  final QueryDocumentSnapshot docx;

  @override
  _HeadPartBookState createState() => _HeadPartBookState();
}

class _HeadPartBookState extends State<HeadPartBook> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .doc(widget.docx.id)
          .collection('time')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
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
                        widget.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Muli',
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                      Text(
                        widget.speciality,
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
                      children: [
                        Center(child: Text('No Appointments'),)
                      ]
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(widget.imageUrl),
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
                        widget.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Muli',
                            fontSize: MediaQuery.of(context).size.width * 0.07),
                      ),
                      Text(
                        widget.speciality,
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
                        String date = "00";
                        String month = "34";
                        String year = "2002";
                        String timeHour = "34";
                        String timeSec = "34:";
                        Timestamp dateFromDb = document['appointmentTime'];
                        String timestamp = dateFromDb.toDate().toString();
                        date = timestamp.split("-")[2];
                        month = timestamp.split("-")[1];
                        year = timestamp.split("-")[0];
                        String laterHalf = timestamp.split(" ")[1];
                        timeHour = laterHalf.split(":")[0];
                        timeSec = laterHalf.split(":")[1];

                        return DateContainer(
                            date:
                                "${date.split(" ")[0]} ${numberMonth(month)} ",
                            year: year,
                            time: "$timeHour:$timeSec ${amPm(timeHour)}");
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

  amPm(String hour) {
    if (int.parse(hour) >= 12) {
      return "PM";
    } else {
      return "AM";
    }
  }

  numberMonth(String monthNumber) {
    switch (monthNumber) {
      case ("01"):
        return "January";
        break;
      case ("02"):
        return "February";
        break;
      case ("03"):
        return "March";
        break;
      case ("04"):
        return "April";
        break;
      case ("05"):
        return "May";
        break;
      case ("06"):
        return "June";
        break;
      case ("07"):
        return "July";
        break;
      case ("08"):
        return "August";
        break;
      case ("09"):
        return "September";
        break;
      case ("10"):
        return "October";
        break;
      case ("11"):
        return "November";
        break;
      case ("12"):
        return "December";
        break;
      default:
    }
  }
}

class DateContainer extends StatefulWidget {
  DateContainer({this.date, this.year, this.time});

  final String date;
  final String year;
  final String time;

  @override
  _DateContainerState createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelected ? isSelected = false : isSelected = true;
        if (isSelected) {
          appointmentData.pushData(widget.date, widget.year, widget.time);
          enableAppointButton = true;
          setState(() {});
        } else {
          appointmentData.disposeAppointmentData();
          enableAppointButton = false;
          setState(() {});
        }
        setState(() {});
      },
      child: Card(
        color: isSelected ? Colors.green : Colors.white,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.year,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.037),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.date,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.time,
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
