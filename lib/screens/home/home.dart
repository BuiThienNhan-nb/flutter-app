import 'dart:ui';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/home/all_destination.dart';
import 'package:flutter_app/screens/home/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/screens/home/status_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_listview_item/hor_destination_card.dart';
import 'custom_listview_item/province_cate_item.dart';
import 'custom_listview_item/recommended_destination_card.dart';

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
          color: Palette.myLightGrey,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 60),
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
                      itemCount:
                          destinationController.listDestinations.length >= 5
                              ? 5
                              : destinationController.listDestinations.length,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Provinces List',
                      style: GoogleFonts.varelaRound(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AllDestinationScreen(),
                            transition: Transition.rightToLeft);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'See all',
                            style: GoogleFonts.varelaRound(fontSize: 16),
                          ),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                    ),
                  ],
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
                    itemBuilder: (context, index) => Container(
                      padding: EdgeInsets.only(bottom: 12),
                      child: HorizontalDestinationCard(
                        destination: destinationController
                            .listDestinationsByProvince[index],
                        function: destinationController.navigateToDesDetail,
                        size: size,
                        tag:
                            'horizontal-${destinationController.listDestinationsByProvince[index].uid}',
                      ),
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
