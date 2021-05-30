
import 'package:flutter/cupertino.dart';
import 'package:medico/Pages/shop/components/product_card.dart';
import 'package:medico/Pages/shop/components/section_title.dart';
import 'package:medico/details/details_screen.dart';

import 'Product.dart';

class PopUpProducts extends StatelessWidget {
  const PopUpProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: MediaQuery
              .of(context)
              .size
              .height * 0.01),
          child: SectionTitle(text: "Popular Products", press: () {},),
        ),
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.01),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                    (index) {
                   if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index],
                      press:()=>
                      Navigator.pushNamed(context, '/details',
                      arguments: ProductDetailsArguments(product: demoProducts[index])
                      ),
                    );

                  return SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              SizedBox(width: MediaQuery
                  .of(context)
                  .size
                  .height * 0.04),
            ],
          ),
        )
      ],
    );
  }
}
