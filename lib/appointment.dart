import 'package:flutter/material.dart';
import 'Wizards/text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'Wizards/pop_ups.dart';

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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: (){
                showDialog(
                  context: this.context,
                  builder: (BuildContext context) => BuildPopupDialog(),
                );
              },
              splashRadius: 18,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: (){

                },
                icon: Icon(FeatherIcons.shoppingCart),
                splashRadius: 18,
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Color(0xff8f3d3c),

        ),
      ],
    );
  }
}
