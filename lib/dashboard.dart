import 'package:flutter/material.dart';
import 'button_and_text.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dash1 extends StatefulWidget {
  @override
  _Dash1State createState() => _Dash1State();
}

class _Dash1State extends State<Dash1> {
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
          backgroundColor: Color(0xff7851a9),
          body: Container(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: ReusableCard(
                      colour: Color(0xff9b1c31),
                      cardChild: Column(
                        children: [
                          MidText(txtFile: 'Height', colour: Colors.white,),
                        ],
                      ),
                    )),
                    Expanded(child: ReusableCard(
                      colour: Color(0xff4169e1),
                      cardChild: Column(
                        children: [
                          MidText(txtFile: 'Weight', colour: Colors.white,),
                        ],
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: ReusableCard(
                      colour: Color(0xff136207),
                      cardChild: Column(
                        children: [
                          MidText(txtFile: 'Blood Pressure', colour: Colors.white,),
                        ],
                      ),
                    )),
                    Expanded(child: ReusableCard(
                      colour: Color(0xffe73895),
                      cardChild: Column(
                        children: [
                          MidText(txtFile: 'Heart Rate', colour: Colors.white,),
                        ],
                      ),
                    ))
                  ],
                ),
                Expanded(child: ReusableCard(
                  colour: Colors.white,
                  // cardChild: Row(
                  //   children: [
                  //     Icon(Icons.settings),
                  //     Icon(Icons.sensor_door),
                  //     Icon(Icons.notifications),
                  //     Icon(Icons.mediation),
                  //   ],
                  // ),
                ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
