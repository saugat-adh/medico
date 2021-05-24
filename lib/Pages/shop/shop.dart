import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medico/Components/discount_box.dart';
import 'package:medico/Components/shop_header.dart';

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
            backgroundColor: Colors.white,
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



                  // Stack(
                  //   clipBehavior: Clip.none,
                  //   alignment: AlignmentDirectional.topCenter,
                  //   children: [
                  //     _buildBackgroundCover(),
                  //     _buildTextFile(),
                  //     _buildCartItem(),
                  //     _buildSearchBar(),
                  //   ],
                  // ),
                ],
              ),
            )),
      ],
    );
  }

}
class Categories extends StatelessWidget {
  const Categories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories=[
      {"icon": "images/feather/zap.svg", "text": "Flash Deal"},
      {"icon": "images/feather/archive.svg", "text": "Bill"},
      {"icon": "images/feather/headphones.svg", "text": "Care"},
      {"icon": "images/feather/slack.svg", "text": "More"},
    ];

    return Padding(
      padding:EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width*0.05,
      vertical: MediaQuery.of(context).size.width*0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(categories.length, (index) => CategoryCard(
              icon: categories[index]["icon"],
              text: categories[index]["text"],
              press: (){

          }))
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.press,
  }) : super(key: key);
  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.13,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(

                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 236, 223),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  icon,)
                ),
                ),

            
            const SizedBox(height: 5,),
            Text(text,
              style: TextStyle(color: Colors.brown[200]),
              textAlign: TextAlign.center,
              textScaleFactor: 0.9,
            ),
          ],
        ),
      ),
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
