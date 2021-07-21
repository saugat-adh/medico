import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key key,
    @required  this.imgURL,
  }) : super(key: key);

  final String imgURL;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.2),
          child: SizedBox(width:MediaQuery.of(context).size.width*0.75 ,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      //border: Border.all(color: Colors.blue.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0,6),
                        ),
                      ]
                  ),
                  child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 1.5,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(imgURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
            ),),
        ),

      ],
    );
  }
}
