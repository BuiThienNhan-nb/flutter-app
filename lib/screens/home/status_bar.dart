import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeStatusBar extends StatelessWidget {
  const HomeStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.11;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel Exploring App',
              style: GoogleFonts.caveat(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Text(
              UserRepo.customer.name!.isEmpty
                  ? 'Hello, guest!'
                  : 'Hello, ${UserRepo.customer.name}!',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        Spacer(
            // flex: 12,
            ),
        // Icon(
        //   Icons.notifications,
        //   color: Colors.grey,
        // ),
        // Spacer(
        //   flex: 1,
        // ),
        Container(
          height: size,
          child: ClipOval(
            child: UserRepo.customer.imageUrl == ''
                ? Container(
                    width: size,
                    color: Colors.grey.shade400,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    ),
                  )
                : CachedNetworkImage(
                    width: size,
                    fit: BoxFit.fill,
                    imageUrl: UserRepo.customer.imageUrl!,
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
        ),
      ],
    );
  }
}
