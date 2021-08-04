import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medico/Pages/shop/cart/components/Cart.dart';


class CartCard extends StatelessWidget {
  final QueryDocumentSnapshot docs;
  final String quantity;

  const CartCard({Key key, this.docs, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.01),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(docs['ProductImageUrl'],),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              docs['Name'],
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                // text: docs['Description'],
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey),
                children: [
                  TextSpan(
                      text: quantity,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}