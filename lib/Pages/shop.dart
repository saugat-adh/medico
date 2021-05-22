import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dash3 extends StatefulWidget {
  @override
  _Dash3State createState() => _Dash3State();
}

class _Dash3State extends State<Dash3> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.greenAccent[200],
    //   statusBarBrightness: Brightness.dark,
    // ));
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
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

                        ),
                        Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.001),
                              height: MediaQuery.of(context).size.height*0.1,
                              width: MediaQuery.of(context).size.width*0.1,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                              ) ,
                              child: IconButton(
                                icon: Icon(
                                  FeatherIcons.shoppingCart,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),


                            ),
                            Positioned(
                              right:-1,
                              top: 1,
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.05,
                                width: MediaQuery.of(context).size.width*0.05,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(width: 1.5,color: Colors.white)
                                ),
                                child: Center(
                                  child: Text("3",
                                    style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width*0.03,
                                      height: 1,
                                      color: Colors.white,
                                  ),),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
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
            Colors.green,
            Colors.teal,
          ],
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
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
          onPressed: () {},
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
            )),
            centerTitle: true,
            backgroundColor: Colors.white,
            primary: false,
            title: TextField(
              decoration: InputDecoration(
                hintText: "Search Meds",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              )
            ]));
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
    throw UnimplementedError();
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
