import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      {@required this.txt,
      this.types,
      this.pass,
      this.cntrl,
      this.labelTxt,
      this.ico,
      this.formatters,
      this.validator,
      this.onChanged,
      this.error});

  final String txt;
  final TextInputType types;
  final String Function(String) validator;
  final bool pass;
  final TextEditingController cntrl;
  final String labelTxt;
  final Icon ico;
  final List<TextInputFormatter> formatters;
  final Function(String) onChanged;
  final String error;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      onChanged: onChanged,
      controller: cntrl,
      validator: validator,
      obscureText: pass ?? false,
      keyboardType: types,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        suffixIcon: ico,
        errorText: error,
        labelText: labelTxt,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontFamily: 'Muli',
        ),
        contentPadding: EdgeInsets.all(15),
        hintText: txt,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: MediaQuery.of(context).size.width * 0.04,
          fontFamily: 'Muli',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            )),
      ),
    );
  }
}
