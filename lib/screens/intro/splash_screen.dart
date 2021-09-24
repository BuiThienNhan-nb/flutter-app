import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      Get.offAllNamed('/mainContainer');
      showSnackbar(
          "Login succesful", 'Welcome back ${UserRepo.customer.name}', true);
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                color: Color(0xFF4e954e),
                fontSize: !expanded ? _bigFontSize : 50,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
              child: Text(
                "N",
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
          "GHIA",
          style: TextStyle(
            color: Colors.black,
            fontSize: 50,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: LottieBuilder.asset(
            'assets/food.json',
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
