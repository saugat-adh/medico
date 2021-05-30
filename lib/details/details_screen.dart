import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/Components/rounded_icon_btn.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName="/details";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFFF5F6F9),
        leading: RoundedIconBtn(
          iconData: Icons.arrow_back_ios_rounded,
          press: ()=>Navigator.pop(context),
        ),

      ),
    );
  }
}



class ProductDetailsArguments{
  final Product product;
  ProductDetailsArguments({@required this.product});
}
