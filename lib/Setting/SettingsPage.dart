import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool showPopUp = false;
  String infoText;
  Widget mediaPreview;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
      ),
      body: GestureDetector(
        onTap: () {
          showPopUp = false;
          setState(() {});
        },
        child: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.white70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "General Settings",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                buildOptions()
              ],
            ),
          ),
          showPopUp
              ? showPopUpInfo(infoText)
              : SizedBox(
                  height: 0,
                ),
        ]),
      ),
    );
  }

  Widget showPopUpInfo(String optionClicked) {
    if (optionClicked == "OurTeam") {
      mediaPreview = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Our Team",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Kathmandu University Students"),
              ),
            ),
          )
        ],
      );
    } else if (optionClicked == "AppInfo") {
      mediaPreview = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "App Info",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Beta Version 0.0.5"),
              ),
            ),
          )
        ],
      );
    } else {
      mediaPreview = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Contact Us",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              //height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Medico"),
              ),
            ),
          )
        ],
      );
    }

    return Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediaPreview,
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    showPopUp = false;
                    setState(() {});
                  },
                  child: Center(child: Text("Close"))),
            )
          ],
        ));
  }

  GestureDetector options(VoidCallback action, String optionName) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(optionName),
        ),
      ),
    );
  }

  Widget buildOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white54, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              options(() {
                showPopUp = true;
                infoText = "OurTeam";
                setState(() {});
              }, "Our Team"),
              Divider(),
              options(() {
                showPopUp = true;
                infoText = "Contact Us";
                setState(() {});
              }, "Contact Us"),
              Divider(),
              options(() {
                showPopUp = true;
                infoText = "AppInfo";
                setState(() {});
              }, "About App"),
            ],
          ),
        ),
      ),
    );
  }
}
