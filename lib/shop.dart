import 'package:flutter/material.dart';
import 'Wizards/text.dart';
import 'Wizards/buttons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'Wizards/pop_ups.dart';

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
          backgroundColor: Colors.teal,

    ),],);
  }
}
