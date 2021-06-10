import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:medico/Pages/appointments/book_page/components/headPart.dart';

class BookPage extends StatefulWidget {

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            HeadPartBook(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 3,
              blurRadius: 10,
            )
          ],
          color: Colors.white,
        ),
        height: 80,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff0118B5),
                borderRadius: BorderRadius.circular(25),
              ),
              width: MediaQuery.of(context).size.width - 90,
              child: Center(
                  child: TextButton(
                    onPressed: () {
                    },
                    child: Text(
                      'Book',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Muli',
                          fontSize:
                          MediaQuery.of(context).size.width * 0.05),
                    ),
                  )),
            ),
          ),
        ),
      ),
    ));
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
