import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SpecialOfferCard(
            image: "images/medicine1.jpg",
            category: "Vitamins",
            numOfBrands: 40,
            press: (){

            },
          ),
          SpecialOfferCard(
            image: "images/antibiotics1.jpg",
            category: "Antibiotics",
            numOfBrands: 15,
            press: (){

            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.05,)
        ],
      ),
    );
  }
}

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
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.06),
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.64,
        height: MediaQuery.of(context).size.height*0.16,
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
                          Colors.black.withOpacity(0.5),
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