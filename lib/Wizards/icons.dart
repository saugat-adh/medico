import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';



class IcoBtn extends StatelessWidget {
  IcoBtn({@required this.ico, @required this.onClick});

  final Icon ico;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        iconSize: 25,
        color: Colors.grey,
        icon: ico,
        onPressed: onClick,
      ),
    );
  }
}

