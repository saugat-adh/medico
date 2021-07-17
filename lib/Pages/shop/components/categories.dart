import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Pharma/mainScreen.dart';

class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories=[
      {"icon": "images/feather/zap.svg", "text": "Flash Deal"},
      {"icon": "images/feather/archive.svg", "text": "Bill"},
      {"icon": "images/feather/headphones.svg", "text": "Care"},
      {"icon": "images/feather/slack.svg", "text": "More"},
    ];

    return Padding(
      padding:EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.08,
          vertical: MediaQuery.of(context).size.width*0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(categories.length, (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: (){

              }))
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.13,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(

                  decoration: BoxDecoration(
                    color: Colors.blueGrey[600],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: FractionallySizedBox(
                    heightFactor: 0.90,
                    child: IconButton(
                      icon: SvgPicture.asset(
                        icon, color: Colors.white70, ),
                      splashRadius: 40,
                      onPressed: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>Pharma()));

                      },
                    ),
                  )
              ),
            ),


            const SizedBox(height: 5,),
            Text(text,
              style: TextStyle(
                  color: Colors.black45,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
