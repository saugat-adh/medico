
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomAppBar extends PreferredSize{
  final double rating;

  CustomAppBar(this.rating);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(FeatherIcons.arrowLeft),
              onPressed: () {
                Navigator.pop(context);

              },),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),

                    color: Colors.white,

                  ),

                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(rating.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600
                            )),
                      ),
                      const SizedBox(width: 0.5,
                      ),
                      IconButton(icon: Icon(Icons.star,
                        color: Colors.orange,) , onPressed: (){

                      })

                    ],

                  ),
                )

            ),

          ],
        ),
      ),
    );
  }
}
