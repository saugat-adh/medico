import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:gender_picker/gender_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'Wizards/forms.dart';

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
                        _buildFormContainer(),
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
              Navigator.pop(context);
            });
          },
        ));
  }
}
_buildFormContainer() {
  return Positioned(
      bottom: 200,
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
            _buildUserHeight(),
            SizedBox(
              height: 10,
            ),
            _buildUserWeight(),
            SizedBox(
              height: 10,
            ),
            textGender(),
            _genderWidget(false,false),

          ],
        ),
      ));
}

_genderWidget(bool _showOther, bool _alignment){
  return Container(
    child: new Column(
      children: [
        new Container(

        ),
        new Container(
          alignment: Alignment.center,
          child: GenderPickerWithImage(
            showOtherGender: _showOther,
            verticalAlignedText: _alignment,
            onChanged: (Gender _gender) {
              print(_gender);
            },
            selectedGender: Gender.Male,
            selectedGenderTextStyle: TextStyle(fontWeight: FontWeight.bold),
            unSelectedGenderTextStyle: TextStyle(fontWeight: FontWeight.normal),),
        )
      ],
    )
     );
}


textGender(){
  return Container(
    child: new Text("Gender"),
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
    types: TextInputType.phone,
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
      types: TextInputType.visiblePassword,
      ico: Icon(
        FeatherIcons.arrowUp,
        color: Colors.grey,
      ));
}
_buildUserWeight() {
  return TextFieldForm(
      txt: 'Weight',
      pass: true,
      types: TextInputType.visiblePassword,
      ico: Icon(
        FeatherIcons.arrowRight,
        color: Colors.grey,
      ));
}


