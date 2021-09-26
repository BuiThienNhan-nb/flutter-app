import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/custom_listview_item/hor_destination_card.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    destinationController.listFavDestination.bindStream(
        DestinationRepo().favDestinationStream(UserRepo.customer.favoriteDes));
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
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 0, 30),
          child: Container(
            child:
                // Obx(
                //   () =>
                ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: destinationController.listFavDestinations.length,
              itemBuilder: (context, index) => Slidable(
                actionPane: SlidableScrollActionPane(),
                actionExtentRatio: 0.3,
                child: HorizontalDestinationCard(
                  destination: destinationController.listFavDestinations[index],
                  function: destinationController.navigateToDesDetail,
                  size: 300.0,
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Remove',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      DestinationRepo().updateUserFav(
                          destinationController.listFavDestinations[index],
                          true);
                    },
                  ),
                ],
              ),
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
