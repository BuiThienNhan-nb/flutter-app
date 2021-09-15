import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int cont = 0;
  int targetCount = 5;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('Animation ${cont + 1} completed. ');
        cont++;
        if (cont < 10) {
          _animationController.reset();
          _animationController.forward();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'helloworld',
            body: 'nice body',
            footer: LottieBuilder.asset(
              'assets/plane.json',
              onLoaded: (composition) {
                _animationController.duration = composition.duration;
                _animationController.forward();
              },
              frameRate: FrameRate.max,
              repeat: false,
              animate: true,
              height: 300,
              width: 300,
              controller: _animationController,
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'helloworld',
            body: 'nice body',
            footer: LottieBuilder.asset(
              'assets/tourist-travel.json',
              onLoaded: (composition) {
                _animationController.duration = composition.duration;
                _animationController.forward();
              },
              frameRate: FrameRate.max,
              repeat: false,
              animate: true,
              height: 300,
              width: 300,
              controller: _animationController,
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'helloworld',
            body: 'nice body',
            footer: LottieBuilder.asset(
              'assets/traveler.json',
              onLoaded: (composition) {
                _animationController.duration = composition.duration;
                _animationController.forward();
              },
              frameRate: FrameRate.max,
              repeat: false,
              animate: true,
              height: 300,
              width: 300,
              controller: _animationController,
            ),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text(
          'Start',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onDone: () => Get.offAllNamed("/authenticate"),
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
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24.0),
      pageColor: Colors.white);
}
