import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/details/Components/product_images.dart';
class Body extends StatelessWidget {

  final Product product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductImages(product: product),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width*0.04,
          ),
          child: TopRoundedContainer(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width*0.04,
                ),
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({

    Key key,
    @required this.child,@required this.color,
  }) : super(key: key);
  final Widget child;
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
        )

      ),

    );
  }
}

