import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/screens/setting/editProfile/edit_profile.dart';
import 'package:flutter_app/screens/setting/settingChild.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  signOut() async {
    AuthenticationServices _auth = AuthenticationServices();
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        // backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Setting Page nè! ${pageDisplayController.count}'),
          // backgroundColor: Palette.myColor,
        ),
        body: Container(
          // color: Colors.grey[200],
          child: Center(
            child: Column(
              children: [
                ButtonWidget(
                    text: 'Go to Child Screen',
                    onClicked: () {
                      Get.to(() => EditProfile(),
                          transition: Transition.leftToRight);
                    }),
                ButtonWidget(text: "Logout", onClicked: signOut),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
