import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/const_values/string_value.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages: [
          PageViewModel(
            title: StringValue.title,
            body: StringValue.Description1,
            image: Image.asset('assets/man_take_picture.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: StringValue.title,
            body: StringValue.Description2,
            image: Image.asset('assets/world.png'),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: StringValue.title,
            body: StringValue.Description3,
            image: Image.asset('assets/walk_man.png'),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text(
          'Start',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onDone: () => Get.offAllNamed("/login"),
        showSkipButton: true,
        skip: Text('skip'),
        next: Icon(Icons.arrow_forward),
        showDoneButton: true,
        dotsDecorator: getDocDecoration());
  }

  DotsDecorator getDocDecoration() => DotsDecorator(
      color: Color(0xFFBDBDBD),
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ));

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Palette.orange),
      bodyTextStyle: TextStyle(fontSize: 20, color: Colors.grey[600]),
      titlePadding: EdgeInsets.only(top: 70.0),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.only(top: 20.0),
      pageColor: Colors.white);
}
