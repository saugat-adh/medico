import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class iconButtonWithCounter extends StatelessWidget {

  const iconButtonWithCounter({
    @required this.svgSrc,
    this.numOfItems = 0,
    @required this.press,
    Key key,
  }) : super(key: key);
  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.001),
            height: MediaQuery.of(context).size.height*0.11,
            width: MediaQuery.of(context).size.width*0.11,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ) ,
            child: IconButton(
              icon: Icon(
                FeatherIcons.shoppingCart,
                color: Colors.black,
              ),
              onPressed: () {},
            ),


          ),
          if(numOfItems !=0)
            Positioned(
              right:-1,
              top: 6,
              child: Container(
                height: MediaQuery.of(context).size.height*0.055,
                width: MediaQuery.of(context).size.width*0.055,
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5,color: Colors.white)
                ),
                child: Center(
                  child: Text("3",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.028,
                      height: 1,
                      color: Colors.white,
                    ),),
                ),
              ),
            ),

        ],
      ),
    );
  }
}