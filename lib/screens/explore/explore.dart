import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
        title: Text('Explore Page nè!'),
        // backgroundColor: Palette.myColor,
      ),
      body: Container(
        // color: Colors.blue[50],
        child: Center(
          child: ButtonWidget(text: 'Logout', onClicked: signOut),
        ),
      ),
    );
  }
}
