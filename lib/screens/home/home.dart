import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/home/utils/status_bar.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:flutter_app/utils/destination_card.dart';
import 'package:flutter_app/utils/email_field_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  signOut() async {
    AuthenticationServices _auth = AuthenticationServices();
    await _auth.signOut();
    Get.offAllNamed('/authenticate');
  }

  @override
  Widget build(BuildContext context) {
    final c = TextEditingController();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeStatusBar(),
                SizedBox(
                  height: 15,
                ),
                EmailFieldWidget(controller: c),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommend',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: destinationController.listProvinces.length,
                      itemBuilder: (context, index) => DestinationCard(
                          function: () {},
                          province: destinationController.listProvinces[index]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
