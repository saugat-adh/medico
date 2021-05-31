import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/components/Product.dart';
import 'package:medico/details/Components/product_images.dart';
class Body extends StatelessWidget {

  final Product product;
  const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProductImages(product: product);
  }
}

