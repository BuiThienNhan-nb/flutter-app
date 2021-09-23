import 'package:flutter/material.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class FavoriteButton extends StatefulWidget {
  final size;
  bool isFavorite;
  int count;
  final Destination destination;
  FavoriteButton({
    Key? key,
    this.size,
    required this.isFavorite,
    required this.count,
    required this.destination,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: widget.size,
      isLiked: widget.isFavorite,
      likeCount: widget.count,
      onTap: (isLiked) async {
        final bool _success = await DestinationRepo()
            .updateUserFav(widget.destination, widget.isFavorite);
        widget.count = widget.destination.favorites = _success
            ? (widget.isFavorite ? widget.count - 1 : widget.count + 1)
            : widget.count;
        widget.isFavorite = _success ? !widget.isFavorite : widget.isFavorite;
        return _success ? !isLiked : isLiked;
      },
      // circleColor:
      //     CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      // bubblesColor: BubblesColor(
      //   dotPrimaryColor: Color(0xff33b5e5),
      //   dotSecondaryColor: Color(0xff0099cc),
      // ),
      likeBuilder: (bool isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.red : Colors.grey,
          size: widget.size * 0.7,
        );
      },
      likeCountPadding: const EdgeInsets.only(left: 0.0),
      countBuilder: (count, isLiked, text) {
        var color = isLiked ? Colors.red : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "love",
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        return result;
      },
    );
  }
}

// Future<bool> onLikeButtonTapped(bool isLiked) async {
//   /// send your request here
//   // final bool success= await sendRequest();

//   /// if failed, you can do nothing
//   // return success? !isLiked:isLiked;
//   // DestinationRepo().updateUserFav(id).then((value) {
//   //   return !isLiked;
//   // });
//   return !isLiked;
// }
