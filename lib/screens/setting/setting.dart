import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  signOut() async {
    AuthenticationServices _auth = AuthenticationServices();
    await _auth.signOut();
    Get.offAllNamed('/authenticate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting Page nè!'),
        // backgroundColor: Palette.myColor,
      ),
      body: Container(
        child: Center(
          child: ButtonWidget(text: 'Logout', onClicked: signOut),
        ),
      ),
    );
  }
}
