import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.075),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.64,
        height: MediaQuery.of(context).size.height*0.15,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(image,
                fit: BoxFit.cover,),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.45),
                          Colors.black38.withOpacity(0.2),
                        ]
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width*0.05,
                  vertical: MediaQuery.of(context).size.width*0.05,
                ),
                child: Text.rich(
                    TextSpan(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                              text: "$category \n",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width*0.06,
                                fontWeight: FontWeight.bold,
                              )

                          ),TextSpan(
                              text: "$numOfBrands Brands"
                          )
                        ]
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}