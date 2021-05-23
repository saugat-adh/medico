import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width*0.70,
      height:50,
      decoration:BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),

      ),
      child: TextField(
        onChanged: (value){

        },
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Search Meds",
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width*0.05,
              vertical: MediaQuery.of(context).size.width*0.04),
        ),
      ) ,

    );
  }
}