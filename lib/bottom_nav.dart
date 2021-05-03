import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:medico/button_and_text.dart';


class BotNavBar extends StatefulWidget {
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;

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
                Navigator.pop(context);
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
                canvasColor: Colors.white,
            ),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  label: '',
                  activeIcon: Icon(Icons.dashboard),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services_outlined),
                    label: '',
                  activeIcon: Icon(Icons.medical_services),
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_basket_outlined),
                    label: '',
                  activeIcon: Icon(Icons.shopping_basket),
                ),
                //BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color(0xff56AC81),
              unselectedItemColor: Color(0xff2c6b4c),
              elevation: 0,
              onTap: _onItemTapped,
              iconSize: 30,
            ),
          ),
        ),
    );
  }
}
