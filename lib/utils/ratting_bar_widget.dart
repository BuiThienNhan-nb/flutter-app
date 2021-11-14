import 'package:flutter_app/models/destinations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RattingBar extends StatefulWidget {
  // final double initalRating;
  // bool? isRatting = false;
  // final Destination destination;
  // RattingBar(
  //     {Key? key,
  //     required this.initalRating,
  //     this.isRatting,
  //     required this.destination})
  //     : super(key: key);

  @override
  _RattingBarState createState() => _RattingBarState();
}

class _RattingBarState extends State<RattingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        itemBuilder: (context, _) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
        },
      ),
    );
  }
}
