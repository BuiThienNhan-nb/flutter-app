import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/models/provinces.dart';
import 'package:get/get.dart';

class DestinationCard extends StatelessWidget {
  // final Destination destination;
  final Province province;
  final Function function;
  const DestinationCard({
    Key? key,
    // required this.destination,
    required this.function,
    required this.province,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _image = CachedNetworkImage(
    //   fit: BoxFit.fill,
    //   imageUrl: destination.imageUrl,
    // );
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(' ${province.name} '),
    );
  }
}
