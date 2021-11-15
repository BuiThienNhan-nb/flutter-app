import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:flutter_app/screens/home/destination_detail/destination_detail.dart';

class SearchField extends StatelessWidget {
  final size;
  const SearchField({Key? key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double borderRadius = 20;
    return Container(
      width: size * 1.35,
      height: size * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: size * 1.35,
            height: size * 0.22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Search Destination...',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Palette.myLightGrey,
                borderRadius: BorderRadius.circular(borderRadius),
                onTap: () =>
                    showSearch(context: context, delegate: SearchData()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchData extends SearchDelegate<Destination> {
  @override
  String? get searchFieldLabel => 'Search Destination...';

  var tag = '';
  late Destination _destination;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
            context,
            Destination(
                uid: '',
                name: '',
                description: '',
                imageUrl: '',
                videoUrl: '',
                favorites: 0,
                geoPoint: GeoPoint(0, 0)));
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return DestinationDetail(
      destination: _destination,
      tag: tag,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? destinationController.listDestinations
        : destinationController.listDestinations
            .where((element) => element.name
                .toLowerCase()
                .trim()
                .startsWith(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          _destination = suggestion[index];
          tag = 'search-${suggestion[index].uid}';
          // showResults(context);
          destinationController.navigateToDesDetail(suggestion[index], tag);
          // close(context,
          //     Destination(uid: '', name: '', description: '', imageUrl: ''));
        },
        leading: Icon(Icons.arrow_forward_ios),
        title: RichText(
          text: TextSpan(
            text: suggestion[index].name.substring(0, query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestion[index].name.substring(query.length),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestion.length,
    );
  }
}
