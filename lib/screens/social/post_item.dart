import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/screens/social/post_fav_button.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class PostItem extends StatefulWidget {
  final Post post;
  final Function callBack;
  const PostItem({Key? key, required this.post, required this.callBack})
      : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    destinationController.listPosts;
    return Obx(
      () => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: (widget.post.customer.value.imageUrl == '' ||
                          widget.post.customer.value.imageUrl == null)
                      ? Container(
                          height: deviceWidth * 0.08,
                          width: deviceWidth * 0.075,
                          color: Colors.grey.shade400,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35,
                          ),
                        )
                      : CachedNetworkImage(
                          height: deviceWidth * 0.08,
                          width: deviceWidth * 0.075,
                          fit: BoxFit.fill,
                          imageUrl: widget.post.customer.value.imageUrl!,
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
                Container(width: deviceWidth * 0.02),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.post.customer.value.name}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${DateFormat('dd/M/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.post.postDate.seconds * 1000))} - ${widget.post.destination.value.name}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                Spacer(),
                PostFavoriteButton(
                  size: deviceWidth * 0.08,
                  isFavorite:
                      UserRepo.customer.favoritePost!.contains(widget.post.uid),
                  count: widget.post.favorites,
                  post: widget.post,
                  callback: (Post post) {
                    // destinationController.fetchEntireSpecificPost(post);
                    setState(() {});
                  },
                ),
              ],
            ),
            Container(height: deviceHeight * 0.01),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.post.content}",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(height: deviceHeight * 0.01),
            Container(
              height: deviceHeight * 0.3,
              width: deviceWidth * 0.9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: widget
                                    .post.destination.value.imageUrl.isEmpty
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
                                    height: deviceHeight * 0.3,
                                    width: deviceWidth * 0.9,
                                    imageUrl:
                                        widget.post.destination.value.imageUrl,
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
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
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Palette.myLightGrey,
                        splashFactory: InkRipple.splashFactory,
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => destinationController.navigateToDesDetail(
                            widget.post.destination.value,
                            "from-social-${widget.post}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: deviceHeight * 0.01),
          ],
        ),
      ),
    );
  }
}
