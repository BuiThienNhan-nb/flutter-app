import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/screens/home/destination_detail/comment/all_comment.dart';
import 'package:flutter_app/screens/home/destination_detail/carousel_des_widget.dart';
import 'package:flutter_app/screens/home/destination_detail/content_text_field.dart';
import 'package:flutter_app/services/postRepo.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/services/weather.dart';
import 'package:flutter_app/utils/fav_button.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _contentTxtController = TextEditingController();
  WeatherModel weatherModel = WeatherModel();
  int temperature = 0;
  String weatherIcon = '☀️';
  String weatherMessage = 'a';

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

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getMessage(temperature);
    });
  }

  void initContext() async {
    var weatherData =
        await weatherModel.getLocationWeather(widget.destination.geoPoint);
    if (!mounted) return;
    updateUI(weatherData);
  }

  @override
  void dispose() {
    _controller.close();
    _contentTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // String videoUrl = widget.destination.videoUrl.toString();
    const player = YoutubePlayerIFrame();
    initContext();
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
                        widget.destination.imagesUrl.length > 1
                            ? CarouselDestinationWidget(
                                destination: widget.destination,
                                size: Size(size.width, size.height * 0.45))
                            : Container(
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
                                              style: TextStyle(
                                                  color: Colors.white60),
                                            ),
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.destination.imageUrl,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey,
                                            highlightColor:
                                                Colors.grey.shade200,
                                            child: Stack(
                                              children: [
                                                Positioned.fill(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
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
                                    IconButton(
                                      onPressed: () {
                                        sharePost();
                                      },
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
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
                                          fontSize: 28),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "$weatherIcon",
                                          style: TextStyle(fontSize: 35),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "$temperature°",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 25),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Container(
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
                      padding: EdgeInsets.only(left: 18, right: 18, bottom: 15),
                      child: player,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      alignment: Alignment.centerLeft,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FavoriteButton(
                            isFavorite: UserRepo.customer.favoriteDes!
                                .contains(widget.destination.uid),
                            count: widget.destination.favorites,
                            size: 40.0,
                            destination: widget.destination,
                          ),
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllComment(
                                  nameDes: widget.destination.name,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.comment),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('Comments')
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => navigateToMap(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  EvaIcons.navigation2,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Maps',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void sharePost() {
    Get.bottomSheet(Container(
      color: Colors.white,
      padding: EdgeInsets.all(12),
      child: Wrap(
        children: [
          Text(
            'Contents',
            style: GoogleFonts.varelaRound(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          Form(
              key: _formKey,
              child: ContentTextFieldWidget(
                  controller: _contentTxtController,
                  icon: Icon(Icons.content_copy),
                  hintText: "Content",
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  await PostRepo().addPost(
                    Post(
                        uid: '',
                        content: "${_contentTxtController.text.trim()}",
                        customer: UserRepo.customer.obs,
                        destination: widget.destination.obs,
                        postDate: Timestamp.fromDate(DateTime.now()),
                        favorites: 0),
                  );
                  Get.back();
                  showSnackbar("Posting", 'Share destination success', true);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Text("Share", style: TextStyle(color: Palette.orange)),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  void navigateToMap() {
    String query = Uri.encodeComponent(widget.destination.name);
    String ggMapUrlByDesName =
        "https://www.google.com/maps/search/?api=1&query=$query";
    launch(ggMapUrlByDesName);
  }
}
