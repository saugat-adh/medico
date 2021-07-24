import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Components/search_field.dart';
import 'package:medico/Pages/appointments/components/HeaderButton.dart';
import 'package:medico/Pages/appointments/search_bar/search_bar.dart';


class AppointmentHeader extends StatelessWidget {


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
          HeaderButton(text: 'Appointments',size: 25,),
        InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.001),
              height: MediaQuery.of(context).size.height*0.11,
              width: MediaQuery.of(context).size.width*0.11,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ) ,
              child: IconButton(
                  icon: Icon(
                    FeatherIcons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
              ),


            ),

          ],
        ),
      ),
        ],
      ),
    );
  }
}
