import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/controllers/destinationController.dart';
import 'package:flutter_app/controllers/pageDisplayController.dart';
import 'package:flutter_app/screens/authenticate/authentication.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/intro/onboarding_screen.dart';
import 'package:flutter_app/screens/intro/splash_screen.dart';
import 'package:flutter_app/screens/main_container.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  // document.documentElement!.requestFullscreen();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(PageDisplayController());
    Get.put(DestinationController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(primaryColor: Palette.darkOrange),

      // theme: ThemeData(
      //   primaryColor: Palette.myColor,
      //   primarySwatch: Colors.blue,
      // ),

      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Palette.myOrangeMaterialColor,
      ),

      // home: Authenication(),
      getPages: [
        GetPage(
          name: "/mainContainer",
          page: () => MainContainer(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/authenticate",
          page: () => Authenication(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/splashScreen",
          page: () => SplashScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/onboardingScreen",
          page: () => OnboardingScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
      ],
      initialRoute: '/splashScreen',
    );
  }
}
