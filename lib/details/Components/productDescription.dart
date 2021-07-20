
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:medico/details/Components/product_images.dart';
import 'package:readmore/readmore.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key key,
    this.title, this.productDescription, this.productPrice,
  }) : super(key: key);
  final String title;
  final String productDescription;
  final String productPrice;

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImages(

        ),
        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width*0.04,
          ),
          child: TopRoundedContainer(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width*0.04,
                    vertical: MediaQuery.of(context).size.height*0.019,
                  ),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width*0.04),
                  child: ReadMoreText(
                    widget.productDescription,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: '...Show more',
                    trimExpandedText: 'Show less',
                    moreStyle: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Muli',
                        fontSize: MediaQuery.of(context).size.width * 0.039,
                        fontWeight: FontWeight.bold),
                    lessStyle: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Muli',
                        fontSize: MediaQuery.of(context).size.width * 0.039,
                        fontWeight: FontWeight.bold),
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'Muli',
                      fontSize: MediaQuery.of(context).size.width * 0.039,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Center(child: Text("Give us a rating")),
                Center(
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),

              ],
            ),
          ),
        ), //Product Description
        SizedBox(height: 40,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.08),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(FeatherIcons.shoppingCart),
              label: Text(
                "Add to Cart".toUpperCase(),
                style: TextStyle(fontSize: 15),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.red)
                    )
                ),
              ),

              onPressed: (){},


            ),
          ),
        ),
        //Add to cart option
      ],
    );
  }
}
class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({

    Key key,
    @required this.child,@required this.color,
    @required this.press,
  }) : super(key: key);
  final Widget child;
  final GestureTapCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.02),
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.02),
      width: double.infinity,
      //height: MediaQuery.of(context).size.width*0.70,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )

      ),

    );
  }
}