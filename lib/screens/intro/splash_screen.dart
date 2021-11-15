import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/screens/authenticate/verify_email.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<SplashScreen>
    with TickerProviderStateMixin {
  static late AnimationController lottieAnimation;
  var expanded = false;
  double _bigFontSize = kIsWeb ? 234 : 178;
  final transitionDuration = Duration(seconds: 1);

  @override
  void initState() {
    lottieAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    Future.delayed(Duration(seconds: 1))
        .then((value) => setState(() => expanded = true))
        .then((value) => Duration(seconds: 1))
        .then((value) => Future.delayed(Duration(seconds: 1)))
        .then((value) => lottieAnimation.forward())
        .then((value) => {
              //navigate to another screen, page
              navigate()
            });

    super.initState();
  }

  navigate() async {
    // AuthenticationServices _auth = AuthenticationServices();
    // await _auth.signOut();
    if (FirebaseAuth.instance.currentUser != null) {
      UserRepo userRepo = UserRepo();
      await userRepo
          .fetchUser(FirebaseAuth.instance.currentUser!.uid)
          .then((value) => UserRepo.customer = value);
      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAllNamed('/mainContainer');
        showSnackbar(
            "Login succesful", 'Welcome back ${UserRepo.customer.name}', true);
      } else {
        Get.to(() => VerifyEmail(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 800));
      }
    } else {
      Get.offAllNamed("/onboardingScreen");
    }
  }

  @override
  Widget build(BuildContext context) {
    destinationController.fetchEntirePost();
    return Material(
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDefaultTextStyle(
              duration: transitionDuration,
              curve: Curves.fastOutSlowIn,
              style: TextStyle(
                color: Palette.orange,
                fontSize: !expanded ? _bigFontSize : 50,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
              child: Text(
                "T",
              ),
            ),
            AnimatedCrossFade(
              firstCurve: Curves.fastOutSlowIn,
              crossFadeState: !expanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: transitionDuration,
              firstChild: Container(),
              secondChild: _logoRemainder(),
              alignment: Alignment.bottomCenter,
              sizeCurve: Curves.easeInOut,
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoRemainder() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "RAVEL",
          style: TextStyle(
            color: Palette.orange,
            fontSize: 50,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          child: LottieBuilder.asset(
            'assets/travel.json',
            onLoaded: (composition) {
              lottieAnimation..duration = composition.duration;
            },
            frameRate: FrameRate.max,
            repeat: false,
            animate: false,
            height: 90,
            width: 90,
            controller: lottieAnimation,
          ),
        )
      ],
    );
  }
}
