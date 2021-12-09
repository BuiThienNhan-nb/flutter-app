import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFieldBirthday extends StatelessWidget {
  TextFieldBirthday(
      {required this.labelText,
      required this.placeholder,
      required this.textEditingController,
      required this.callback});
  final String labelText;
  final String placeholder;
  final Callback callback;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate =
        DateFormat('dd/MM/yyyy').parse(textEditingController.text);

    void _selectDate(BuildContext context) async {
      DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2021),
      );

      if (newSelectedDate != null) {
        _selectedDate = newSelectedDate;
        textEditingController
          ..text = DateFormat('dd/MM/yyyy').format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: textEditingController.text.length,
              affinity: TextAffinity.upstream));
        callback(textEditingController.text);
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: textEditingController,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        onTap: () {
          _selectDate(context);
        },
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
        enableSuggestions: false,
        autocorrect: false,
        onChanged: (a) => TextInput.finishAutofillContext(),

        // onEditingComplete: () => TextInput.finishAutofillContext(),
      ),
    );
  }
}

typedef Callback = Function(String _newDateString);

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
