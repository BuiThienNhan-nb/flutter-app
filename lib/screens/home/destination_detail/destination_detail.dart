import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/screens/home/destination_detail/all_comment.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/fav_button.dart';
// import 'package:flutter_app/utils/ratting_bar_widget.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';

class DestinationDetail extends StatefulWidget {
  final Destination destination;
  final tag;
  DestinationDetail({
    Key? key,
    required this.destination,
    this.tag,
  }) : super(key: key);
  @override
  State<DestinationDetail> createState() => _DestinationDetailState();
}

class _DestinationDetailState extends State<DestinationDetail> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.destination.videoUrl.toString(),
      params: const YoutubePlayerParams(
        startAt: const Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // String videoUrl = widget.destination.videoUrl.toString();
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: player),
                  const SizedBox(
                    width: 500,
                  ),
                ],
              );
            }
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: size.height * 0.45,
                          child: Hero(
                            tag: widget.tag,
                            child: widget.destination.imageUrl.isEmpty
                                ? Container(
                                    color: Colors.black87,
                                    child: Center(
                                      child: Text(
                                        "Has no image yet",
                                        style: TextStyle(color: Colors.white60),
                                      ),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: widget.destination.imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.45,
                          color: Colors.black12,
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.share,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    FavoriteButton(
                                      isFavorite: UserRepo.customer.favoriteDes!
                                          .contains(widget.destination.uid),
                                      count: widget.destination.favorites,
                                      size: 40.0,
                                      destination: widget.destination,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.destination.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 23),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white70,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Koh Chang Tai, Thailand",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        RatingBar(2.1.round()),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "2.1",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
                                // child: RattingBar(
                                //   initalRating: destination.rattingPoint,
                                //   destination: destination,
                                //   isRatting: isRatting(UserRepo.customer.rattingDes),
                                // ),
                                // padding: EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                height: size.height * 0.03,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: player,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "${widget.destination.description}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 15,
                            height: 1.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff879D95)),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    MaterialButton(
                      textColor: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllComment(
                              nameDes: widget.destination.name,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.comment),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('add comment')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool isRatting(List<Map<String, dynamic>> list) {
    List<String> newList = [];
    for (var i in list) {
      var valueList = i.entries.toList();
      newList.add(valueList[0].value);
    }
    if (newList.contains(widget.destination.uid)) {
      return true;
    }
    return false;
  }
}

class RatingBar extends StatelessWidget {
  final int rating;
  RatingBar(this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: rating >= 1 ? Colors.white70 : Colors.white30,
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 2 ? Colors.white70 : Colors.white30,
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 3 ? Colors.white70 : Colors.white30,
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 4 ? Colors.white70 : Colors.white30,
        ),
        SizedBox(
          width: 3,
        ),
        Icon(
          Icons.star,
          color: rating >= 5 ? Colors.white70 : Colors.white30,
        ),
      ],
    ));
  }
}
// Scaffold(
//       backgroundColor: Colors.white,
//       body: 
//     );
