import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Database/Appointment.dart';
import 'package:medico/Pages/appointments/book_page/components/headPart.dart';
import 'package:medico/Database/Appointment.dart';
import 'package:medico/Pages/home_page.dart';

class BookPage extends StatefulWidget {
  final QueryDocumentSnapshot docs;

  const BookPage(this.docs);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void dispose() {
    super.dispose();
    appointmentData.disposeAppointmentData();
  }

  final _appointmentService = AppointmentService.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            HeadPartBook(
              name: widget.docs['First name'] + ' ' + widget.docs['Last name'],
              speciality: widget.docs['speciality'],
              imageUrl: widget.docs['ImgUrl'],
              docx: widget.docs,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 10,
            )
          ],
          color: Colors.white,
        ),
        height: 80,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: EdgeInsets.all(0)),
            onPressed: () {
              if (appointmentData.date.length > 1 ||
                  appointmentData.year.length > 1) {
                print("Greater Scenario");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text("You cannot select multiple appointment time")));
              } else if (appointmentData.date.length == 0 ||
                  appointmentData.year.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Make an appointment first")));
              } else {
                try {
                  print("Doneee");
                  _appointmentService.makePateintAppointment(
                      doctorInformation: widget.docs);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Appointment Made")));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong")));
                }
              }
            },
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Book',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.05),
                ),
              ),
            ),
          )),
        ),
      ),
    ));
  }

  _buildBackButton() {
    return IconButton(
      icon: Icon(FeatherIcons.arrowLeft),
      color: Colors.black,
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
        minHeight: 80,
        minWidth: 80,
      ),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }
}
