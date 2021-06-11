import 'package:flutter/material.dart';

List<String> days = [
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
];

List<String> time = ['1:00', '2:00', '5:00', '9:00'];

class HeadPartBook extends StatelessWidget {
  HeadPartBook({this.speciality, this.name, this.imageUrl});

  final String name;
  final String speciality;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
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
            'Select Day',
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
                  ...List.generate(
                      days.length, (index) => DateContainer(day: days[index])),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Select Time',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...List.generate(
                    time.length,
                    (index) => TimeContainer(
                          time: time[index],
                        )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  DateContainer({this.day});

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
                  fontSize: MediaQuery.of(context).size.width * 0.037),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '999',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            )
          ],
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
