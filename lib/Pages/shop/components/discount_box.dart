import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountsBox extends StatelessWidget {
  const DiscountsBox({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.09
      ),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.05,
          vertical: MediaQuery.of(context).size.width*0.04),
      width: double.infinity,
      //height: 90,
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
          TextSpan(
              text: "Covid Essentials\n",
              style: TextStyle(color: Colors.white),
              children: [
                TextSpan(
                    text: "Free Home Delivery",
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold
                    )
                )

              ]
          )
      ),
    );
  }
}
