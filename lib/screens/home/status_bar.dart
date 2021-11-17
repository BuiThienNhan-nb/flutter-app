import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeStatusBar extends StatelessWidget {
  const HomeStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.11;
    destinationController.bindAvaUrl(UserRepo.customer.uid);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel Exploring App',
              style: GoogleFonts.varelaRound(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              UserRepo.customer.name!.isEmpty
                  ? 'Hello, guest!'
                  : 'Hello, ${UserRepo.customer.name}!',
              style: GoogleFonts.caveat(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Spacer(
            // flex: 12,
            ),
        Obx(
          () => Container(
            height: size,
            child: ClipOval(
              child: destinationController.avatarUrl == ''
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
                      imageUrl: destinationController.avatarUrl,
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
        ),
      ],
    );
  }
}
