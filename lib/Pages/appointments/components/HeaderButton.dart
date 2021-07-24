import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  HeaderButton({this.text, this.press, this.size});
  final String text;
  final Function press;
  final double size;

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
              fontSize: size ?? MediaQuery.of(context).size.width*0.04,
              fontStyle: FontStyle.normal,
            ),),
          GestureDetector(
            onTap: press,
            child:  Text("",
              style:TextStyle(
                color: Colors.black38,
              ) ,),
          )
        ],
      ),
    );
  }
}
