import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/controllers/destinationController.dart';
import 'package:flutter_app/controllers/get_list_des_controller.dart';
import 'package:flutter_app/controllers/pageDisplayController.dart';
import 'package:flutter_app/screens/authenticate/login.dart';
import 'package:flutter_app/screens/intro/onboarding_screen.dart';
import 'package:flutter_app/screens/intro/splash_screen.dart';
import 'package:flutter_app/screens/main_container.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(PageDisplayController());
    Get.put(DestinationController());
    Get.put(CommentController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Palette.orangeMaterialColor,
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
          name: "/login",
          page: () => LoginScreen(toggleScreen: () {}),
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
