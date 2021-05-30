import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/Components/rounded_icon_btn.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName="/details";



  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments=
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar:CustomAppBar(arguments.product.rating),
    );
  }
}


class CustomAppBar extends PreferredSize{
  final double rating;

  CustomAppBar(this.rating);
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          IconButton(
              icon: Icon(FeatherIcons.arrowLeft),
            onPressed: () {
                Navigator.pop(context);

            },),
            Padding(
              padding: EdgeInsets.only(top: 14),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
          color: Colors.white,

          ),

                  child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(rating.toString(),
                  style: TextStyle(
                        fontWeight: FontWeight.w600
                  )),
                    ),
                    const SizedBox(width: 0.5,
                    ),
                    IconButton(icon: Icon(Icons.star,
                    color: Colors.orange,) , onPressed: (){

                    })

                  ],

              ),
                )

              ),

          ],
        ),
      ),
    );
  }
}



class ProductDetailsArguments{
  final Product product;
  ProductDetailsArguments({@required this.product});
}
