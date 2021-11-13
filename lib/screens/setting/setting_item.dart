import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function()? function;
  const SettingItem({
    Key? key,
    required this.iconData,
    required this.text,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Palette.orange,
                  size: 30,
                ),
                SizedBox(width: 20),
                Text(
                  "$text",
                  style: GoogleFonts.varelaRound(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Palette.myLightGrey,
                borderRadius: BorderRadius.circular(20),
                onTap: function,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
