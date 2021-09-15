import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/const_values/value.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final IconData icon;
  final String typeValidation;

  const TextInputField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.textInputType,
      required this.icon,
      required this.typeValidation})
      : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppValue.TextFormFieldContainerHieght,
      child: TextFormField(
        style: TextStyle(fontSize: AppValue.AuthFontSize),
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(
            widget.icon,
            size: AppValue.AuthFontSize * 1.4,
          ),
        ),
        keyboardType: widget.textInputType,
        autofillHints: [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
        validator: (input) {
          if (input == null || input.isEmpty)
            return '${widget.hintText} is required';
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
      ),
    );
  }
}
