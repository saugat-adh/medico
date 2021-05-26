import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width=140,
    this.aspectRation=1.02,
    @required this.product,
  }) : super(key: key);


  final double width, aspectRation;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width*0.08,

      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: aspectRation,
                  child: Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                    decoration: BoxDecoration(
                      color: Colors.white70.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),

                    ),
                    child: FittedBox(
                      child: Image.asset(product.images[0],
                        fit: BoxFit.fill,),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(product.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textScaleFactor: 1,
                  maxLines: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Rs ${product.price}",
                      style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.w600),
                      textScaleFactor: 1.2,),
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: (){

                      },
                      child: Container(
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                        width: MediaQuery.of(context).size.width*0.06,
                        height: MediaQuery.of(context).size.height*0.06,
                        decoration: BoxDecoration(
                          color: product.isFavourite
                              ?Colors.white30.withOpacity(0.4)
                              :Colors.orange[700],
                          shape: BoxShape.circle,
                        ),
                        child: FractionallySizedBox(
                            heightFactor: 0.90,
                            child: SvgPicture.asset("images/feather/heart.svg")),
                      ),
                    )
                  ],
                ),
              ],
            ),

          )
        ],
      ),
    );
  }
}
