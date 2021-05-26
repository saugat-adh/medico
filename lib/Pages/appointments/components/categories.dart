import 'package:flutter/material.dart';
import 'package:medico/Pages/appointments/expain_page/doctor_explained.dart';
import 'package:medico/constants.dart';

class CategoriesAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Let\'s find your doctor'),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ...List.generate((docCategories.length), (index) {
            if (index % 2 == 0) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryPanel(
                    text: docCategories[index]["text"],
                    press: () { Navigator.pushNamed(context, DoctorExp.id);},
                    ico: docCategories[index]["icon"],
                  ),
                  CategoryPanel(
                      text: docCategories[index + 1]["text"],
                      press: () {},
                      ico: docCategories[index + 1]["icon"]),
                ],
              );
            } else {
              return Text('');
            }
          })
        ],
      ),
    );
  }
}

class CategoryPanel extends StatelessWidget {
  CategoryPanel({this.press, this.text, this.ico});

  final String text, ico;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.42,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(ico),)
                      ),
                    ),
                  ),
                  Text(
                    text,
                    style: TextStyle(color: Colors.black, fontFamily: 'Muli'),
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.9,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
