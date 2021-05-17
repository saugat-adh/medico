import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'Wizards/forms.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'Wizards/buttons.dart';
import 'Pages/bottom_nav.dart';

class InfoForm extends StatefulWidget {
  static const String id = 'info_form';

  @override
  _InfoFormState createState() => _InfoFormState();
}

class _InfoFormState extends State<InfoForm> {
  String infoGender;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
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
            )),
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
                      SizedBox(
                        height: 100,
                      ),
                      _buildFormContainer(),
                      _buildButton(),
                    ],
                  ),
                ],
              ),
            ),
          )),
        ]),
      ),
    );
  }

  _buildContainer() {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 49,
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
              Navigator.pop(context);
            });
          },
        ));
  }

  _buildFormContainer() {
    return Positioned(
        top: 200,
        child: Container(
          //height: 300,
          width: 350,
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 5.5,
                blurRadius: 5.5,
              )
            ],
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildUserName(),
              SizedBox(
                height: 10,
              ),
              _buildUserAddress(),
              SizedBox(
                height: 10,
              ),
              _buildUserEmail(),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: _buildUserHeight()),
                  Expanded(child: _buildUserWeight())
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textGender(),
              Center(child: _genderWidget(true, true)),
            ],
          ),
        ));
  }

  _genderWidget(bool _showOther, bool _alignment) {
    return Container(
        child: new Column(
      children: [
        new Container(
          alignment: Alignment.center,
          child: GenderPickerWithImage(
            showOtherGender: _showOther,
            verticalAlignedText: _alignment,
            onChanged: (Gender _gender) {
              infoGender = EnumToString.convertToString(_gender);
              print(infoGender);
            },
            selectedGender: null,
            selectedGenderTextStyle: TextStyle(fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle: TextStyle(fontWeight: FontWeight.normal),
            maleImage: AssetImage('images/male.png'),
            femaleImage: AssetImage('images/female.png'),
            otherGenderImage: AssetImage('images/others.png'),
            size: 70,
            opacityOfGradient: 0.2,
          ),
        )
      ],
    ));
  }

  textGender() {
    return Container(
      child: new Text(
        "Gender",
        style: TextStyle(
          fontFamily: 'Coda',
        ),
      ),
    );
  }

  _buildUserName() {
    return TextFieldForm(
        txt: 'Name',
        pass: true,
        types: TextInputType.text,
        ico: Icon(
          FeatherIcons.user,
          color: Colors.grey,
        ));
  }

  _buildUserEmail() {
    return TextFieldForm(
      txt: 'Email',
      ico: Icon(
        FeatherIcons.mail,
        color: Colors.grey,
      ),
      types: TextInputType.emailAddress,
    );
  }

  _buildUserAddress() {
    return TextFieldForm(
      txt: 'Address',
      ico: Icon(
        FeatherIcons.map,
        color: Colors.grey,
      ),
      types: TextInputType.streetAddress,
    );
  }

  _buildUserHeight() {
    return TextFieldForm(
        txt: 'Height',
        pass: true,
        types: TextInputType.number,
        ico: Icon(
          FeatherIcons.arrowUp,
          color: Colors.grey,
        ));
  }

  _buildUserWeight() {
    return TextFieldForm(
      txt: 'Weight',
      pass: true,
      types: TextInputType.number,
    );
  }

  _buildButton() {
    return Positioned(
      bottom: 70,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, BotNavBar.id);
        },
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Continue',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Bebas',
                letterSpacing: 0.7),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(EdgeInsets.all(0.0)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
      ),
    );
  }
}
