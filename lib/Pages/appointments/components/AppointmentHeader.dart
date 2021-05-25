import 'package:flutter/material.dart';
import 'package:medico/Components/search_field.dart';


class AppointmentHeader extends StatelessWidget {
  const AppointmentHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: SearchField(txt: 'Search Doctors',)),
        ],
      ),
    );
  }
}
