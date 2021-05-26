import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:readmore/readmore.dart';

class BodyPart extends StatelessWidget {
  const BodyPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biography',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(height: 10,),
              ReadMoreText(
                  'Singing is the act of producing musical sounds with the voice. A person who sings is called a singer or vocalist (in jazz and popular music). Singers perform music (arias, recitatives, songs, etc.) that can be sung with or without accompaniment by musical instruments. Singing is often done in an ensemble of musicians, such as a choir of singers or a band of instrumentalists.',
                trimLines: 3,
                trimMode: TrimMode.Line,
                trimCollapsedText: '...Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.039,
                  fontWeight: FontWeight.bold
                ),
                lessStyle: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'Muli',
                    fontSize: MediaQuery.of(context).size.width * 0.039,
                    fontWeight: FontWeight.bold
                ),
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Muli',
                  fontSize: MediaQuery.of(context).size.width * 0.039,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Contact',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(FeatherIcons.mail, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Text(
                    'nxxix@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.047,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(FeatherIcons.phone, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Text(
                    '+977 1234567890',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.047,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(FeatherIcons.map, color: Colors.grey,),
                  SizedBox(width: 10,),
                  Text(
                    'Bharatpur, Chitwan',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.047,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                'Leave a rating',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(5, (index) => Icon(FeatherIcons.star, color: Colors.grey,))
                ],
              ),
              SizedBox(height: 10,),
              Text(
                'Reviews',
                style: TextStyle(
                    fontFamily: 'Muli',
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
