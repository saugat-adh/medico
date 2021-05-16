import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dash3 extends StatefulWidget {
  @override
  _Dash3State createState() => _Dash3State();
}

class _Dash3State extends State<Dash3> {
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
                      _buildBackgroundCover(),
                      _buildTextFile(),
                      _buildCartItem(),
                      _buildSearchBar(),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }

  _buildBackgroundCover() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff45062E),
            Color(0xff7F055F),
          ],
        ),
      ),
    );
  }

  _buildTextFile() {
    return Positioned(
      top: 30,
      left: 20,
      child: Text(
        'Shop',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          //fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _buildCartItem() {
    return Positioned(
      top: 40,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: IconButton(
          icon: Icon(
            FeatherIcons.shoppingCart,
            color: Colors.black,
          ),
          onPressed: () {

          },
        ),
      ),
    );
  }

  _buildSearchBar() {
    return Positioned(
      bottom: 30,
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.all(10),
          child: Center(
            child: Text(
              'This will contain search bar',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
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

