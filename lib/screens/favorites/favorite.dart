import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/custom_listview_item/hor_destination_card.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RxList<Destination> _destination = UserRepo.customer.favoriteDes.obs;
    destinationController.loadFavDes(UserRepo.customer.favoriteDes);
    ever(UserRepo.customer.favoriteDes.obs, destinationController.loadFavDes);
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorites',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          child:
              // Obx(
              //   () =>
              ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: destinationController.listFavDestinations.length,
            itemBuilder: (context, index) => HorizontalDestinationCard(
              destination: destinationController.listFavDestinations[index],
              function: destinationController.navigateToDesDetail,
              size: 300.0,
            ),
          ),
          // ),
        ),
      ),
    );
  }
}
