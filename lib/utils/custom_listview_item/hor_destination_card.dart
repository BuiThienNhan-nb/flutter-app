import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalDestinationCard extends StatelessWidget {
  final Destination destination;
  final Function function;
  final size;
  const HorizontalDestinationCard(
      {Key? key, required this.destination, required this.function, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double borderRadius = 15.0;
    final tag = 'horizontal-${destination.uid}';
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      width: size,
      // height: size,
      child: Stack(
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: tag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: destination.imageUrl.isEmpty
                      ? Container(
                          color: Colors.grey.shade400,
                        )
                      : CachedNetworkImage(
                          width: size * 0.4,
                          height: size * 0.3,
                          fit: BoxFit.fill,
                          imageUrl: destination.imageUrl,
                          placeholder: (context, url) => Shimmer.fromColors(
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  // color: Colors.grey.shade300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${destination.name}',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.mitr(
                          fontSize: 17,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${destination.description}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          // fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Palette.myLightGrey,
                splashFactory: InkRipple.splashFactory,
                borderRadius: BorderRadius.circular(borderRadius),
                onTap: () => function(destination, tag),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
