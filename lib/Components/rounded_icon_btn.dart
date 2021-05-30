import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key key,
    @required this.iconData,
    @required this.press,
  }) : super(key: key);
  final IconData iconData;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.01,
      height: MediaQuery.of(context).size.height*0.01,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(iconData),
        onPressed:press,
        color: Colors.black,
      ),
    );
  }
}
