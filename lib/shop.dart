import 'package:flutter/material.dart';
//import 'button_and_text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dash3 extends StatefulWidget {
  @override
  _Dash3State createState() => _Dash3State();
}

class _Dash3State extends State<Dash3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Shop'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                onPressed: (){

                },
                icon: Icon(FeatherIcons.shoppingCart),
                splashRadius: 18,
              ),
            ],
            //automaticallyImplyLeading: false,
          ),
          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: Text('Tyra'),
                    accountEmail: Text('tyra@mug.com'),
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                currentAccountPicture: GestureDetector(
                  child: new CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                  ),
                ) ,)
              ],
            ),
          ),
          backgroundColor: Colors.teal,

    );
  }

}



