import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:medico/Pages/appointments/book_page/components/headPart.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;

class DocPanel extends StatefulWidget {

  @override
  _DocPanelState createState() => _DocPanelState();
}

class _DocPanelState extends State<DocPanel> {
  DateTime _appointmentTime = DateTime.now();

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> _oFormKey = GlobalKey<FormState>();
  TextEditingController _controller1;
  // List<String> dateData = ["July 5","2021"];
  //   List<String> timeData =

  //String _initialValue = '';

  String _valueSaved1 = '';
  TextEditingController myController;

  @override
  void initState() {
    super.initState();
    myController = new TextEditingController();
    //_initialValue = DateTime.now().toString();
    _controller1 = TextEditingController(text: DateTime.now().toString());
    _getValue();
  }

  Future<void> _getValue() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _controller1.text = '2000-09-20 14:30';
      });
    });
  }

  dateProcessor(DateTime now) {
    print(now.toString());

    // String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);

    // List<String> dateData = formattedDate.split("-");
    // List<String> timeData =
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

                  return DayCard(
                      date: "${date.split(" ")[0]} ${numberMonth(month)} ",
                      year: year,
                      time: "$timeHour:$timeSec ${amPm(timeHour)}");
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  _appointmentsMade() {
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
          return Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data.docs.map((document) {
                  String date = "00";
                  String month = "34";
                  String year = "2002";
                  String timeHour = "34";
                  String timeSec = "34:";
                  String patientName = "exapmle";
                  String docDatabase = document['appointementTime'];
                  patientName = document['patientName'] != null
                      ? document['patientName']
                      : "";

                  date = docDatabase.split(" ")[0];
                  month = docDatabase.split(" ")[1];
                  year = docDatabase.split(" ")[2];
                  String laterHalf = docDatabase.split(" ")[3];
                  timeHour = laterHalf.split(":")[0];
                  timeSec = laterHalf.split(":")[1];

                  return DayCard(
                      name: patientName,
                      date: "${date.split(" ")[0]} $month ",
                      year: year,
                      time: "$timeHour:$timeSec ${amPm(timeHour)}");
                }).toList(),
              ),
            ),
          );
        }
      },
    );
  }

  _formatter(String datetime) {
    DateTime trialDate = DateTime.parse(datetime);
    _addAppointment(trialDate);
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

  Future<void> _addAppointment(DateTime _appointmentTime) async {
    _firestore
      ..collection("doctors")
          .doc(firebaseUser.uid)
          .collection('time')
          .add({"appointmentTime": _appointmentTime});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: _oFormKey,
          child: Column(
            children: <Widget>[
              Text("Appointment Schedule"),
              _appointmentScheduler(),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'dd/ MM/ yyyy',
                controller: _controller1,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  return true;
                },
                onSaved: (val) => setState(() => _valueSaved1 = val ?? ''),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    final loForm = _oFormKey.currentState;

                    if (loForm?.validate() == true) {
                      loForm?.save();
                      _formatter(_valueSaved1);
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
              Divider(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {
                    final loForm = _oFormKey.currentState;
                    loForm?.reset();

                    setState(() {
                      _valueSaved1 = '';
                    });

                    _controller1.clear();
                  },
                  child: Text('Reset'),
                ),
              ),
              _appointmentsMade(),
              SizedBox(height: 30,),
              _changeDesc(),
            ],
          ),
        ),
      ),
    );
  }

  _changeDesc() {
    return StreamBuilder(
      stream: _firestore
          .collection('doctors')
          .doc(firebaseUser.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return GestureDetector(
          onTap: (){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Change Your Description',
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
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: new OutlineInputBorder(),
                                  //hintText: hintText
                                ),
                              controller: myController,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ElevatedButton(
                                      child: Text("Save"),
                                      onPressed: () {
                                        _changeData(myController);
                                        myController.clear();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                'Chnaged Sucessfully')));
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.teal),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        myController.clear();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            Colors.teal),
                                      ),
                                    ),
                                  ])),
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Column(
            children:[
              Container(
                width: MediaQuery.of(context).size.width - 20,
                //height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Your Description'),
                      SizedBox(height: 20),
                      Text(snapshot.data['desc']),
                    ],
                  ),
                ),
              )
            ]
          ),
        );
      }
    );
  }
  _changeData(TextEditingController controllerData  ) async {
      await _firestore
          .collection("doctors")
          .doc(firebaseUser.uid)
          .update({'desc': controllerData.text});
  }
}


class DayCard extends StatelessWidget {
  DayCard({this.name, this.year, this.date, this.time});
  final String year;
  final String date;
  final String time;
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            name != null
                ? Text(
                    " To: $name",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Muli',
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  )
                : Text(""),
            Text(
              " Time: $time",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Date: $date$year",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
