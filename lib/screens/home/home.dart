import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/home/utils/status_bar.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:flutter_app/utils/hor_destination_card.dart';
import 'package:flutter_app/utils/recommended_destination_card.dart';
import 'package:flutter_app/utils/email_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size sizeDevice = MediaQuery.of(context).size;
    final size = sizeDevice.width * (6 / 11);

    return SafeArea(
      child: Container(
        // color: Colors.amber,
        padding: EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            // child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeStatusBar(),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: size * 1.35,
                  height: size * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: CupertinoSearchTextField(
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Recommended',
                  style: GoogleFonts.varelaRound(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: size * 1.1,
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: destinationController.listDestinations.length,
                      itemBuilder: (context, index) =>
                          RecommendedDestinationCard(
                              size: size,
                              function: () {},
                              destination: destinationController
                                  .listDestinations[index]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Categories',
                  style: GoogleFonts.varelaRound(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   height: size,
                // Flexible(
                // child:
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: destinationController.listDestinations.length,
                    itemBuilder: (context, index) => HorizontalDestinationCard(
                      destination:
                          destinationController.listDestinations[index],
                      function: () {},
                      size: size,
                    ),
                  ),
                ),
                // ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
