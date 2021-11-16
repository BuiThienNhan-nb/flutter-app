import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedDestinationCard extends StatelessWidget {
  // final Destination destination;
  final Destination destination;
  final Function function;
  final size;
  const RecommendedDestinationCard({
    Key? key,
    // required this.destination,
    required this.function,
    required this.destination,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _image = CachedNetworkImage(
      fit: BoxFit.fill,
      imageUrl: destination.imageUrl,
    );
    final tag = 'recommended-${destination.uid}';

    Widget tagContainer(String head, String des) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: size * 0.82,
                  height: size * 0.3,
                  color: Colors.grey.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 13, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            '${destination.name}',
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.mitr(
                              fontSize: 17.0,
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${destination.favorites} likes",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ))),
      );
    }

    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
      child: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: destination.imageUrl.isEmpty
                        ? Container(
                            color: Colors.black87,
                            child: Center(
                              child: Text(
                                "Has no image yet",
                                style: TextStyle(color: Colors.white60),
                              ),
                            ),
                          )
                        : Container(
                            child: Hero(
                              tag: tag,
                              child: CachedNetworkImage(
                                height: size,
                                width: size,
                                fit: BoxFit.fill,
                                imageUrl: destination.imageUrl,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.grey.shade200,
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: tagContainer('head', 'des'),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Palette.myLightGrey,
                splashFactory: InkRipple.splashFactory,
                borderRadius: BorderRadius.circular(20),
                onTap: () => function(destination, tag),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
