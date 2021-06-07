import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/Product.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.05),
          child: SizedBox(width:MediaQuery.of(context).size.width*0.75 ,
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      //border: Border.all(color: Colors.blue.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3),
                        ),
                      ]
                  ),
                  child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 1,
                    child: Image.asset(product.images[0],
                      fit: BoxFit.cover,),
                  )),
            ),),
        ),
        Row(
          children: [

          ],
        )
      ],
    );
  }
}
