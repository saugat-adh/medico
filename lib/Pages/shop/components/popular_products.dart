
import 'package:flutter/cupertino.dart';
import 'package:medico/Pages/shop/components/product_card.dart';

import 'Product.dart';

class PopUpProducts extends StatelessWidget {
  const PopUpProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
              demoProducts.length,
                  (index)=>ProductCard(product: demoProducts[index])
          ),
          SizedBox(width:MediaQuery.of(context).size.width*0.09)

        ],
      ),
    );
  }
}


