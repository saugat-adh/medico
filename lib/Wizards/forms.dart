import 'package:flutter/material.dart';

class InForm extends StatelessWidget {
  InForm({this.childNote});

  final Widget childNote;

  Widget build(BuildContext context) {
    return Container(
      child: childNote,
      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

class TextFieldForm extends StatelessWidget {
  TextFieldForm(
      {@required this.txt, this.types, this.pass, this.ico, this.cntrl});

  final String txt;
  final TextInputType types;
  final bool pass;
  final Icon ico;
  final TextEditingController cntrl;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cntrl,
      obscureText: pass ?? false,
      keyboardType: types,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        icon: ico,
        contentPadding: EdgeInsets.all(10),
        hintText: txt,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontFamily: 'Coda',
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            )),
      ),
    );
  }
}
