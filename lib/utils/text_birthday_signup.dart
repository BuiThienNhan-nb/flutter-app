import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/const_values/value.dart';

class TextBirthdaySignUp extends StatelessWidget {
  TextBirthdaySignUp({
    required this.hintText,
    required this.textEditingController,
  });
  DateTime _selectedDate = DateTime(2020);
  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppValue.TextFormFieldContainerHieght,
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: textEditingController,
        style: TextStyle(fontSize: AppValue.AuthFontSize),
        onTap: () {
          _selectDate(context);
        },
        decoration: InputDecoration(
          hintText: hintText,
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(
            Icons.cake,
            size: AppValue.AuthFontSize * 1.4,
          ),
        ),
        onEditingComplete: () => TextInput.finishAutofillContext(),
        validator: (input) {
          if (input == null || input.isEmpty) return '${hintText} is required';
        },
        enableSuggestions: false,
        autocorrect: false,
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime(2020),
      firstDate: DateTime(1900),
      lastDate: DateTime(2021),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
