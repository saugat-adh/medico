import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DashIcons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IcoBtn(ico: Icon(
            FeatherIcons.settings,
          ),),
          IcoBtn(ico: Icon(
            FeatherIcons.shoppingCart,
          ),),
          IcoBtn(ico: Icon(
            FeatherIcons.bell,
          ),),
          IcoBtn(ico: Icon(
            FeatherIcons.logOut,
          ),),
        ],
      ),
    );
  }
}

class IcoBtn extends StatelessWidget {
  IcoBtn({@required this.ico});

  final Icon ico;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 25,
        color: Colors.grey,
        icon: ico,
        onPressed: () {
          print('Ok');
        },
      ),
    );
  }
}

