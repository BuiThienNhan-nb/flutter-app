import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/setting/change_password.dart';
import 'package:flutter_app/screens/setting/edit_profile.dart';
import 'package:flutter_app/screens/setting/tosDialog.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/screens/setting/setting_item.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        color: Palette.myLightGrey,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              height: deviceHeight * 0.2,
              child: Text(
                'Settings',
                style: GoogleFonts.varelaRound(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: deviceHeight * 0.05),
            SettingItem(
              iconData: Icons.person,
              text: "Edit Profile",
              function: () {
                Get.to(() => EditProfile(), transition: Transition.rightToLeft);
              },
            ),
            SettingItem(
              iconData: Icons.email,
              text: "Contact via Email",
              function: () async {
                final toEmail = "buithiennhan2016@gmail.com";
                final subject = "Contact from Travel";
                final body = "Report/Cooperate/Suggestion...";
                launch("mailto:$toEmail?subject=$subject&body=$body");
              },
            ),
            SettingItem(
              iconData: Icons.supervised_user_circle,
              text: "Terms Of Service",
              function: () {
                Get.defaultDialog(
                  title: "Data Policy",
                  content: TermOfServiceDialog(deviceHeight: deviceHeight),
                );
              },
            ),
            SettingItem(
              iconData: Icons.password,
              text: "Change Password",
              function: () {
                Get.to(() => ChangePassword(),
                    transition: Transition.rightToLeft);
              },
            ),
            SettingItem(
              iconData: Icons.logout,
              text: "Sign out",
              function: () => signOut(),
            ),
          ],
        ),
      ),
    );
  }
}
