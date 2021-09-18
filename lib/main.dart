import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/authenticate/authentication.dart';
import 'package:flutter_app/screens/google_map/google_map.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/intro/onboarding_screen.dart';
import 'package:flutter_app/screens/intro/splash_screen.dart';
import 'package:flutter_app/screens/main_container.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(primaryColor: Palette.darkOrange),

      // theme: ThemeData(
      //   primaryColor: Palette.myColor,
      //   primarySwatch: Colors.blue,
      // ),

      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Palette.myOrangeMaterialColor,
      ),

      // home: Authenication(),
      getPages: [
        GetPage(
            name: "/mainContainer",
            page: () => MainContainer(
                  pageDisplay: HomeScreen(),
                )),
        GetPage(name: "/authenticate", page: () => Authenication()),
        GetPage(name: "/splashScreen", page: () => SplashScreen()),
        GetPage(name: "/onboardingScreen", page: () => OnboardingScreen()),
        GetPage(name: "/mapscreen", page: () => MapScreen()),
      ],
      initialRoute: '/mapscreen',
    );
  }
}
