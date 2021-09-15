import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/explore/explore.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/setting/setting.dart';

class MainContainer extends StatefulWidget {
  final Widget pageDisplay;
  const MainContainer({Key? key, required this.pageDisplay}) : super(key: key);
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  Widget pageChosen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.lightBlue,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.explore,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (value) {
          setState(() {
            //set on tap icon
            switch (value) {
              case 0:
                pageChosen = HomeScreen();
                break;
              case 1:
                pageChosen = ExploreScreen();
                break;
              case 2:
                pageChosen = SettingScreen();
                break;
              default:
                pageChosen = widget.pageDisplay;
                break;
            }
          });
        },
      ),
      body: Container(
        color: Colors.transparent,
        child: Center(
          //show page
          child: pageChosen,
        ),
      ),
    );
  }
}
