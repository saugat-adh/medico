import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:medico/Pages/home_page.dart';
import 'package:medico/constants.dart';

class AppointmentService {
  AppointmentService._();
  static final instance = AppointmentService._();

  makePateintAppointment(
      {@required QueryDocumentSnapshot doctorInformation}) async {
    String currentUserId = FirebaseAuth.instance.currentUser.uid;
    String appointmentTime =
        "${appointmentData.returnDate()}${appointmentData.returnYear()} ${appointmentData.returnTime()}";
    if (userType == 'patients') {
      FirebaseFirestore.instance
          .collection('patients')
          .doc(currentUserId)
          .collection("docAppointment")
          .doc(doctorInformation.id)
          .set({
        "Doctor": doctorInformation['First name'],
        "appointmentTime": appointmentTime,
      });
    } else {
      FirebaseFirestore.instance
          .collection('doctors')
          .doc(currentUserId)
          .collection("docAppointment")
          .doc(doctorInformation.id)
          .set({
        "Doctor": doctorInformation['First name'],
        "appointmentTime": appointmentTime,
      });
    }

    makeDoctorAppointment(
        doctorInformation: doctorInformation, appointmentTime: appointmentTime);
  }

  makeDoctorAppointment(
      {@required QueryDocumentSnapshot doctorInformation,
      String appointmentTime}) async {
    String currentUserId = FirebaseAuth.instance.currentUser.uid;
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection(userType == 'patients' ? 'patients' : 'doctors')
        .doc(currentUserId)
        .get();
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(doctorInformation.id)
        .collection('Appointment')
        .doc(currentUserId)
        .set({
      "patientName": userDoc['First name'],
      "patientUid": currentUserId,
      "appointementTime": appointmentTime
    });
  }
}
