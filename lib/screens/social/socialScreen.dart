import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/social/post_item.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({Key? key}) : super(key: key);

  @override
  _SocialScreenState createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  bool sortByDate = true;
  @override
  Widget build(BuildContext context) {
    // destinationController.fetchEntirePost();
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Social',
          style: GoogleFonts.varelaRound(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                sortByDate
                    ? destinationController.listPosts
                        .sort((b, a) => a.favorites.compareTo(b.favorites))
                    : destinationController.listPosts
                        .sort((b, a) => a.postDate.compareTo(b.postDate));
                sortByDate = !sortByDate;
              });
            },
            icon: Icon(
              sortByDate ? Icons.date_range : Icons.favorite,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        height: deviceHeight,
        color: Palette.myLightGrey,
        child: RefreshIndicator(
          onRefresh: () async {
            destinationController.fetchEntirePost();
            setState(() {});
          },
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: destinationController.listPosts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(12),
              child: PostItem(
                post: destinationController.listPosts[index],
                callBack: () {
                  destinationController.fetchEntirePost();
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
