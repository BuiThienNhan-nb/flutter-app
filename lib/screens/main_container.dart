import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/favorites/favorite.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/setting/setting.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);
  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  Widget pageChosen = HomeScreen();

  List<Widget> _buildScreens() {
    return [HomeScreen(), FavoriteScreen(), SettingScreen()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Palette.orange,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: ("Explore"),
        activeColorPrimary: Palette.orange,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Palette.orange,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   bottomNavigationBar: CurvedNavigationBar(
    //     height: 55,
    //     backgroundColor: Colors.white,
    //     color: Colors.lightBlue,
    //     items: <Widget>[
    //       Icon(
    //         Icons.home,
    //         size: 30,
    //         color: Colors.white,
    //       ),
    //       Icon(
    //         Icons.explore,
    //         size: 30,
    //         color: Colors.white,
    //       ),
    //       Icon(
    //         Icons.settings,
    //         size: 30,
    //         color: Colors.white,
    //       ),
    //     ],
    //     onTap: (value) {
    //       setState(() {
    //         //set on tap icon
    //         switch (value) {
    //           case 0:
    //             pageChosen = HomeScreen();
    //             pageDisplayController.updatePageDisplay(HomeScreen());
    //             break;
    //           case 1:
    //             pageChosen = ExploreScreen();
    //             pageDisplayController.updatePageDisplay(ExploreScreen());
    //             break;
    //           case 2:
    //             pageChosen = SettingScreen();
    //             pageDisplayController.updatePageDisplay(SettingScreen());
    //             break;
    //           // default:
    //           //   pageChosen = widget.pageDisplay;
    //           //   break;
    //         }
    //       });
    //     },
    //   ),
    //   body: Obx(
    //     () => Container(
    //       color: Colors.transparent,
    //       child: Center(
    //         //show page
    //         child: pageDisplayController.onPageDisplay,
    //       ),
    //     ),
    //   ),
    // );
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      // confineInSafeArea: true,
      // backgroundColor: Colors.transparent,
      // handleAndroidBackButtonPress: true,
      // resizeToAvoidBottomInset: true,
      // stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 60,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.only(left: 0, right: 0, bottom: 0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      decoration: NavBarDecoration(
          colorBehindNavBar: Palette.myColor,
          borderRadius: BorderRadius.circular(50.0)),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style7, // Choose the nav bar style with this property
    );
  }
}
