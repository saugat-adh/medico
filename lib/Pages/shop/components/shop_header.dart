import 'package:flutter/cupertino.dart';
import 'package:medico/Components/search_field.dart';
import 'package:medico/Pages/shop/cart/cart_screen.dart';

import 'icon_btn_with_counter.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(txt: 'Search Meds...',),
          IconButtonWithCounter(
            svgSrc: "images/feather/shopping-cart.svg",
            numOfItems: 1,
            press: ()=> Navigator.pushNamed(context, CartScreen.routeName)
            ,
          ),
        ],
      ),
    );
  }
}