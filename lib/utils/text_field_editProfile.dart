import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldEditProfile extends StatefulWidget {
  TextFieldEditProfile(
      {required this.labelText,
      required this.placeholder,
      required this.controller,
      required this.turnOnOff,
      required this.formatter,
      required this.typeValidation,
      required this.textInputType});
  final String labelText;
  final String placeholder;
  final TextEditingController controller;
  final bool turnOnOff;
  final String typeValidation;
  final TextInputType textInputType;
  TextInputFormatter formatter;

  @override
  _TextFieldEditProfileState createState() => _TextFieldEditProfileState();
}

class _TextFieldEditProfileState extends State<TextFieldEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: widget.placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        controller: widget.controller,
        enabled: widget.turnOnOff,
        inputFormatters: [widget.formatter],
        validator: (input) {
          if (input == null || input.isEmpty)
            return '${widget.placeholder} is required';
          if (widget.typeValidation == 'name') {
            if (input.length < 5) return 'Name is too short';
          }
          if (widget.typeValidation == 'phone') {
            if (input.length > 11 || !input.startsWith('0'))
              return 'Invalid phone number';
          }
        },
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: widget.textInputType,
        onEditingComplete: () => TextInput.finishAutofillContext(),
      ),
    );
  }
}
