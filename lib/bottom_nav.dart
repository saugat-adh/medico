import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:medico/button_and_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

ButtonStyle popUpButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Color(0xff52912E)),
);

class BotNavBar extends StatefulWidget {
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;
  final iconList = [
   Icon(Icons.dashboard_outlined),
    Icon(Icons.medical_services_outlined),
    Icon(Icons.shopping_basket_outlined),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    MidText(
      txtFile: 'Dashboard',
    ),
    MidText(
      txtFile: 'Appointments',
    ),
    MidText(
      txtFile: 'Shop',
    ),
    MidText(
      txtFile: 'Notifications',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: (){
                //Navigator.pop(context);
                showDialog(
                    context: this.context,
                    builder: (BuildContext context) => _buildPopupDialog(),
                );
              },
              splashRadius: 18,
            ),
            title: _widgetOptions.elementAt(_selectedIndex),
            backgroundColor: Color(0xff56AC81),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
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
          backgroundColor: Colors.white,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color(0xff56AC81),
            ),
            child: CurvedNavigationBar(
              backgroundColor: Colors.white,
              items: [
                Icon(Icons.dashboard_outlined, color: Colors.white, size: 30,),
                Icon(Icons.medical_services_outlined, color: Colors.white, size: 30,),
                Icon(Icons.shopping_basket_outlined, color: Colors.white, size: 30,),
              ],
              onTap: _onItemTapped,
              buttonBackgroundColor: Color(0xff56AC81),
              color: Color(0xff56AC81),
            ),
          ),
        ),
    );
  }
}

class _buildPopupDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Do you really want to Sign Out?"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: popUpButton ,
          child: const Text('No'),
        ),
        new TextButton(
          onPressed: (){
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          },
          style: popUpButton,
          child: const Text('Yes'),
        ),
      ],
    );
  }
}


