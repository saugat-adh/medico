import 'package:flutter/material.dart';

List<String> days = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri'
];

class DocPanel extends StatefulWidget {

  @override
  _DocPanelState createState() => _DocPanelState();
}

class _DocPanelState extends State<DocPanel> {
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
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...List.generate(
                days.length, (index) => DayCard(day: days[index])),
          ],
        ),
      ),
    );
  }

  _upcomingSchedules() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          children: [
            ...List.generate(
                6, (index) => ScheduleCard(),)
          ],
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {

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
                Text('Name of Patient'),
                Text('Time: 99'),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class DayCard extends StatelessWidget {
  DayCard({this.day});
  final String day;

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
          ],
        ),
      ),
    );
  }
}

