import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/appointments/search_bar/search_list.dart';

import '../../../constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final firebaseUser = _auth.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DataSearch extends SearchDelegate<String> {


  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for appbar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on left
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    //show results
    return DocListSearch(title: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //show suggestions
    final suggestionList = query.isEmpty
        ? recentDocData
        : docData.where((element) => element.startsWith(query)).toList();
//
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
        },
        leading: Icon(Icons.search_rounded),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring((query.length)),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
