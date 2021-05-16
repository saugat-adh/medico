import 'package:flutter/material.dart';


class Dash2 extends StatefulWidget {
  @override
  _Dash2State createState() => _Dash2State();
}

class _Dash2State extends State<Dash2> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      _buildBackgroundHolder(),
                      _buildText(),
                      _buildSearchBar(),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  _buildBackgroundHolder() {
    return Container(
      height: 250.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff461220),
            Color(0xff8C2F39),
          ],
        ),
      ),
    );
  }

  _buildText() {
    return Positioned(
      top: 50,
        left: 40,
        child: Text(
          'Appointments',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontFamily: 'Bebas',
          ),
    ));
  }

  _buildSearchBar() {
    return Positioned(
        bottom: 50,
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.all(17),
          child: Center(
            child: Text(
              'This will contain search bar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: 'Bebas',
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
        )
    );
  }
}
