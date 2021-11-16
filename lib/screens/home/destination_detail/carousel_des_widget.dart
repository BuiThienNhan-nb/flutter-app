import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDestinationWidget extends StatefulWidget {
  final Destination destination;
  final Size size;
  const CarouselDestinationWidget(
      {Key? key, required this.destination, required this.size})
      : super(key: key);

  @override
  _CarouselDestinationWidgetState createState() =>
      _CarouselDestinationWidgetState();
}

class _CarouselDestinationWidgetState extends State<CarouselDestinationWidget> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: widget.size.height,
              enlargeCenterPage: true,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
            itemCount: widget.destination.imagesUrl.length,
            itemBuilder: (context, index, realIndex) {
              final imageUrl = widget.destination.imagesUrl[index];
              return imageWidget(imageUrl, index, widget.size);
            },
          ),
          Container(
            width: widget.size.width,
            height: widget.size.height * 0.9,
            child: buildIndicator(),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
    );
  }

  Widget imageWidget(String imageUrl, int index, Size size) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.fill,
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
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: widget.destination.imagesUrl.length,
      effect: SlideEffect(
        activeDotColor: Palette.orange,
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }
}
