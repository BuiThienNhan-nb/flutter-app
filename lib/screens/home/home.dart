import 'dart:ui';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/home/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/screens/home/status_bar.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/custom_listview_item/hor_destination_card.dart';
import 'package:flutter_app/utils/custom_listview_item/province_cate_item.dart';
import 'package:flutter_app/utils/custom_listview_item/recommended_destination_card.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // print('LIST FAVORITE DESTINATIONS: ${UserRepo.customer.favoriteDes}');
    Size sizeDevice = MediaQuery.of(context).size;
    final size = sizeDevice.width * (6 / 11);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        // padding: EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeStatusBar(),
                SizedBox(
                  height: 15,
                ),
                SearchField(
                  size: size,
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
                              function:
                                  destinationController.navigateToDesDetail,
                              destination: destinationController
                                  .listDestinations[index]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Provinces List',
                  style: GoogleFonts.varelaRound(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: size * 0.13,
                  child: Obx(
                    () => ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: destinationController.listProvinces.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          setState(() {
                            destinationController.updateSelectedProvince(
                                destinationController.listProvinces[index].uid);
                          });
                        },
                        splashColor: Colors.grey.shade300,
                        // splashFactory: InkRipple.splashFactory,
                        borderRadius: BorderRadius.circular(10),
                        child: ProvinceItem(
                          province: destinationController.listProvinces[index],
                          function:
                              destinationController.updateSelectedProvince,
                        ),
                      ),
                      // ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        destinationController.listDestinationsByProvince.length,
                    itemBuilder: (context, index) => HorizontalDestinationCard(
                      destination: destinationController
                          .listDestinationsByProvince[index],
                      function: destinationController.navigateToDesDetail,
                      size: size,
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
