import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/home/custom_listview_item/hor_destination_card.dart';
import 'package:flutter_app/screens/home/search_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllDestinationScreen extends StatelessWidget {
  const AllDestinationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'All Destinations',
            style: GoogleFonts.varelaRound(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchData());
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: Container(
          height: deviceHeight,
          color: Palette.myLightGrey,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: destinationController.listDestinations.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    child: HorizontalDestinationCard(
                      destination:
                          destinationController.listDestinations[index],
                      function: destinationController.navigateToDesDetail,
                      size: 300.0,
                      tag:
                          'all-destination-${destinationController.listDestinations[index].uid}',
                    ),
                  )),
        ),
      ),
    );
  }
}
