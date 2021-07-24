import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/appointments/components/HeaderButton.dart';
import 'package:medico/Pages/shop/components/shop_header.dart';

class SearchField extends StatelessWidget {
  SearchField({this.txt});

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderButton(text: 'Shop',size: 30,),
          SizedBox(width: MediaQuery.of(context).size.width*0.2,),
          InkWell(
            onTap: (){},
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.001),
                  height: MediaQuery.of(context).size.height*0.11,
                  width: MediaQuery.of(context).size.width*0.11,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ) ,
                  child: IconButton(
                    icon: Icon(
                      FeatherIcons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showSearch(context: context, delegate: ProductDataSearch());
                    },
                  ),


                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}