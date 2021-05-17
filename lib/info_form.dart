import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class InfoForm extends StatefulWidget {
  static const String id = 'info_form';

  @override
  _InfoFormState createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.green,
                    Colors.teal,
                  ],
                )
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        _buildContainer(),
                        _buildBackIcon(),
                        _buildText(),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ]),
    );
  }

  _buildContainer() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
    );
  }

  _buildText() {
    return Positioned(
      left: 30,
        top: 100,
        child: Text(
          'Info',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontFamily: 'Bebas',
          ),
        ),
    );
  }

  _buildBackIcon() {
    return Positioned(
        left: -5,
        child: IconButton(
          icon: Icon(FeatherIcons.arrowLeft),
          color: Colors.white,
          constraints: BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
            minHeight: 80,
            minWidth: 80,
          ),
          onPressed: () {
            setState(() {
              //Navigator.pop(context);
            });
          },
        ));
  }
}
