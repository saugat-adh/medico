import 'package:flutter/material.dart';
import 'package:medico/dashboard.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'appointment.dart';
import 'shop.dart';



class BotNavBar extends StatefulWidget {
  @override
  _BotNavBarState createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;
  List pageKeys = ['Page1', 'Page2', 'Page3'];

  final List<Widget> _children = [
    Dash1(),
    Dash2(),
    Dash3(),
  ];


  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _children[_selectedIndex],
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.dashboard_outlined),
                title: Text("Dashboard "),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.medical_services_outlined),
                title: Text("Appointments"),
                selectedColor: Colors.pink,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_basket_outlined),
                title: Text("Shop"),
                selectedColor: Colors.teal,
              ),
            ],
          ),
        ),
    );
  }
}


