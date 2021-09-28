import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldEditProfile extends StatelessWidget {
  TextFieldEditProfile(
      {required this.labelText,
      required this.placeholder,
      required this.controller,
      required this.turnOnOff,
      required this.formatter});
  final String labelText;
  final String placeholder;
  final TextEditingController controller;
  final bool turnOnOff;
  TextInputFormatter formatter;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        controller: controller,
        enabled: turnOnOff,
        inputFormatters: [formatter],
      ),
    );
  }
}
