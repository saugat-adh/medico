import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width*0.08,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width*0.04,
              fontStyle: FontStyle.normal,
            ),),
          GestureDetector(
            onTap: press,
            child:  Text("See More",
              style:TextStyle(
                color: Colors.black38,
              ) ,),
          )
        ],
      ),
    );
  }
}
