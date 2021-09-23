import 'package:flutter/material.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/services/destinationsRepo.dart';
import 'package:like_button/like_button.dart';

class FavoriteButton extends StatelessWidget {
  final size;
  final bool isFavorite;
  final int count;
  final Destination destination;
  const FavoriteButton({
    Key? key,
    this.size,
    required this.isFavorite,
    required this.count,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size,
      isLiked: isFavorite,
      likeCount: count,
      onTap: (isLiked) async {
        await DestinationRepo().updateUserFav(destination, isFavorite);
        return !isLiked;
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
          size: size * 0.7,
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
