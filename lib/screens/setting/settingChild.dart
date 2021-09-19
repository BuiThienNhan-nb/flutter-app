import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/setting/settingChildChild.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SettingChildScreen extends StatefulWidget {
  const SettingChildScreen({Key? key}) : super(key: key);

  @override
  _SettingChildScreenState createState() => _SettingChildScreenState();
}

class _SettingChildScreenState extends State<SettingChildScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Setting Child nè!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ButtonWidget(
                text: 'Go to ChildChild',
                onClicked: () {
                  pushNewScreen(
                    context,
                    screen: SettingChildChildScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                }),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ButtonWidget(
                text: 'Go back',
                onClicked: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
      // ),
    );
  }
}
