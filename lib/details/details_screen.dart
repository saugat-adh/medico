import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/details/Components/custom_app_bar.dart';
import 'package:medico/details/Components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName="/details";



  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments=
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar:CustomAppBar(arguments.product.rating),
      body: Body(product: arguments.product,),
    );
  }
}




class ProductDetailsArguments{
  final Product product;
  ProductDetailsArguments({@required this.product});
}
