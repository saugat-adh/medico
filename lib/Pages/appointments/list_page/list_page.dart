import 'package:flutter/material.dart';
import 'package:medico/Components/search_field.dart';
import 'package:medico/Pages/appointments/list_page/components/list_doc.dart';

class ListPage extends StatefulWidget {
  const ListPage(this.title);

  final title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'View ' + widget.title + 's',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Muli',
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: DocList(),
          ),
        ),
      ),
    );
  }
}
