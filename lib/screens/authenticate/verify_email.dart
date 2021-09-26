import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/const_values/value.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({
    Key? key,
  }) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  User? user = FirebaseAuth.instance.currentUser;
  late Timer timer;

  Future<void> checkEmailVerified() async {
    await user!.reload();
    user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      timer.cancel();
      Get.offAllNamed('/mainContainer');
      showSnackbar(
          'Register successful', 'Welcome ${UserRepo.customer.name}', true);
      // navigateToHome();
    }
  }

  // Future<void> navigateToHome() async {
  //   UserRepo.customer = Customer(
  //     uid: user!.uid,
  //     email: user!.email,
  //     name: widget.name,
  //     phoneNumber: widget.phone,
  //     favoriteDes: [],
  //     imageUrl: '',
  //   );
  //   UserRepo userRepo = UserRepo();
  //   await userRepo.createUser(UserRepo.customer.uid);
  //   Get.offAllNamed('/mainContainer');
  //   showSnackbar(
  //       'Register successful', 'Welcome ${UserRepo.customer.name}', true);
  // }

  @override
  void initState() {
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            children: [
              Align(
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                width: size.width * 0.6,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/email_noti.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Verify your email',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Text(
                      'Please check your email and follow the instruction to verify your account. If you did not receive an email or if it expired, you can resend one.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  minimumSize: Size(250, 50),
                  // shape: StadiumBorder(),
                  primary: Palette.orange,
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.email),
                      Text(
                        'Resend email',
                        style: TextStyle(
                          fontSize: AppValue.AuthFontSize + 3.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  try {
                    user!.sendEmailVerification();
                  } on PlatformException catch (e) {
                    if (e.code == 'too-many-requests') {
                      return showActionSnackBar(context,
                          'Too many requests, Please check your email');
                    }
                  }
                  return showActionSnackBar(
                      context, 'Email verified has been resended');
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  minimumSize: Size(250, 50),
                  // shape: StadiumBorder(),
                  primary: Colors.red.shade800,
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.delete),
                      Text(
                        'Delete this account',
                        style: TextStyle(
                          fontSize: AppValue.AuthFontSize + 3.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  UserRepo.customer =
                      Customer(uid: '', email: '', name: '', phoneNumber: '');
                  UserRepo userRepo = UserRepo();
                  await userRepo.deleteUser(user!.uid);
                  await user!.delete();
                  showActionSnackBar(context, 'Account has been deleted');
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
