import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Pages/shop/components/discount_box.dart';
import 'package:medico/Pages/shop/components/categories.dart';
import 'package:medico/Pages/shop/components/shop_header.dart';

class Dash3 extends StatefulWidget {
  @override
  _Dash3State createState() => _Dash3State();
}

class _Dash3State extends State<Dash3> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Color(0xffF0F2F8),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  ShopHeader(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  DiscountsBox(),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02),
                  Categories(),
                ],
              ),
            )),
      ],
    );
  }

}









class DataSearch extends SearchDelegate<String> {
  final drugs = [
    "Paracetamol",
    "Vitamin C",
    "Vitamin B",
    "Zinc Tablets",
    "diazepam",
    "fluoxetine",
    "haloperidol",
    "loperamide",
  ];

  final recentDrugs = [
    "Paracetamol",
    // "Vitamin C",
    // "Vitamin B",
    // "Zinc Tablets",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for appbar
    return [
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? recentDrugs
        : drugs.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.person),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }
}
