import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/fav_button.dart';
import 'package:get/get.dart';

class DestinationDetail extends StatelessWidget {
  final Destination destination;
  final tag;
  const DestinationDetail({
    Key? key,
    required this.destination,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.height * 0.5,
                      child: Hero(
                        tag: tag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60)),
                          child: CachedNetworkImage(
                            imageUrl: destination.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.arrow_back_ios_new,
                    //     ),
                    //   ),

                    // )
                  ],
                ),
                FavoriteButton(
                  isFavorite:
                      UserRepo.customer.favoriteDes!.contains(destination.uid),
                  count: destination.favorites,
                  size: 40.0,
                  destination: destination,
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 30),
                  child: Text(
                    '${destination.description}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
