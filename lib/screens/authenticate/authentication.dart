import 'package:flutter/material.dart';
import 'package:flutter_app/screens/authenticate/login.dart';
import 'package:flutter_app/screens/authenticate/signUp.dart';

class Authenication extends StatefulWidget {
  const Authenication({Key? key}) : super(key: key);

  @override
  _AuthenicationState createState() => _AuthenicationState();
}

class _AuthenicationState extends State<Authenication> {
  bool isLogin = true;

  bool isSignined = true;

  toggleScreen() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginScreen(toggleScreen: toggleScreen);
    } else {
      return SignUp(toggleScreen: toggleScreen);
    }
  }
}
