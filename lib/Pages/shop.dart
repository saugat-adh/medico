import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dash3 extends StatefulWidget{

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
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      _buildBackgroundCover(),
                      _buildTextFile(),
                      _buildCartItem(),
                      _buildSearchBar(),
                    ],
                  ),
                ],

              ),
            )),
      ],
    );
  }
  
 

  _buildBackgroundCover() {
    return Container(
      height: 220.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff45062E),
            Color(0xff7F055F),
          ],
        ),
      ),
    );
  }

  _buildTextFile() {
    return Positioned(
      top: 50,
      left: 40,
      child: Text(
        'Shop',
        style: TextStyle(
          fontSize: 50,
          color: Colors.white,
          fontFamily: 'Bebas',
        ),
      ),
    );
  }

  _buildCartItem() {
    return Positioned(
      top: 60,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: IconButton(
          icon: Icon(
            FeatherIcons.shoppingCart,
            color: Colors.black,
          ),
          onPressed: () {

          },
        ),
      ),
    );
  }

  _buildSearchBar() {
    return Positioned(
      top: 150,
      left: 20,
      right: 20,
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
              top: Radius.circular(30),
            )
          ),
          centerTitle: true,
          backgroundColor: Colors.grey,
        primary: false,
        title: TextField(

          decoration: InputDecoration(
            hintText: "Search Meds",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
    actions:<Widget> [
    IconButton(icon: Icon(Icons.search), onPressed: (){
    showSearch(context: context, delegate: DataSearch());
    }
    )
    ]
    )
    );
  }


}


class DataSearch extends SearchDelegate<String> {
  final drugs=[
    "Paracetamol",
    "Vitamin C",
    "Vitamin B",
    "Zinc Tablets",
    "diazepam",
    "fluoxetine",
    "haloperidol",
    "loperamide,"
  ];

  final recentDrugs= [
    "Paracetamol",
    "Vitamin C",
    "Vitamin B",
    "Zinc Tablets",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // actions for appbar
    return [
      IconButton(icon: Icon(Icons.search), onPressed: () {} )
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the appbar
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,progress: transitionAnimation,
    ),
        onPressed: () {});

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList= query.isEmpty?recentDrugs:drugs;
    return ListView.builder(
        itemBuilder: (context,index)=>ListTile(
        leading: Icon(Icons.person),
          title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,
    );
    throw UnimplementedError();
  }

}

