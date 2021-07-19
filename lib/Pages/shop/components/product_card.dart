import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Pages/shop/components/Product.dart';

bool isFavourite= false;


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.width=140,
    this.aspectRation=1.02,
    @required this.press, this.title, this.description, this.quantity, this.productPrice, this.imgURL, Product product,
  }) : super(key: key);



  final double width, aspectRation;
  final String title;
  final String description;
  final String quantity;
  final String productPrice;
  final String imgURL;

  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width*0.08,

      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: press,
            child: SizedBox(
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textScaleFactor: 1,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Rs ${productPrice}",
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
                            color: isFavourite
                                ?Colors.white30.withOpacity(0.4)
                                :Colors.redAccent[100].withOpacity(0.2),
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

            ),
          )
        ],
      ),
    );
  }
}
