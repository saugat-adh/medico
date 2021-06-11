import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HeadPart extends StatelessWidget {
  HeadPart({this.fName, this.lName, this.speciality, this.imageUrl});

  final String fName;
  final String lName;
  final String speciality;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.27,
        width: MediaQuery.of(context).size.width - 30,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 20,
                      blurRadius: 20,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fName + ' ' + lName,
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                    ),
                    Text(speciality,
                        style: TextStyle(
                          fontFamily: 'Muli',
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                          FeatherIcons.star,
                          color: Colors.amber,
                                size: MediaQuery.of(context).size.width * 0.06,
                        ),
                            )),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ratings',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            Text(
                              '4.5 out of 5',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                FeatherIcons.users,
                                color: Color(0xFF0319AA),
                                size: MediaQuery.of(context).size.width * 0.06,
                              ),
                            )),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patients',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: Colors.grey,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            Text(
                              '1000+',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                fontSize:
                                MediaQuery.of(context).size.width * 0.04,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
