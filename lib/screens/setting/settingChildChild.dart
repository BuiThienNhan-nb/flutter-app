import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:get/get.dart';

class SettingChildChildScreen extends StatefulWidget {
  const SettingChildChildScreen({Key? key}) : super(key: key);

  @override
  _SettingChildChildScreenState createState() =>
      _SettingChildChildScreenState();
}

class _SettingChildChildScreenState extends State<SettingChildChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting Child nè!'),
      ),
      body: Center(
        child: ButtonWidget(
            text: 'Go back',
            onClicked: () {
              Navigator.pop(context);
            }),
      ),
      // ),
    );
  }
}
