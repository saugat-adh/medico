import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class ListPage extends StatefulWidget {
  const ListPage(this.title, this.icon);

  final title;
  final icon;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBackButton(),
                  Text(widget.title, style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width *0.1,
                    height: MediaQuery.of(context).size.height *0.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(widget.icon),)
                    ),
                  ),
                  SizedBox(width: 50,),
                ],
              ),]
            ),
          ),
        ),
      ),
    );
  }

  _buildBackButton() {
    return IconButton(
      icon: Icon(FeatherIcons.arrowLeft),
      color: Colors.black,
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
        minHeight: 80,
        minWidth: 80,
      ),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
        });
      },
    );
  }
}
