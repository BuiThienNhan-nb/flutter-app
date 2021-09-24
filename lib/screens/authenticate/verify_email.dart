import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/const_values/value.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  final String name;
  final String phone;
  const VerifyEmail({Key? key, required this.name, required this.phone})
      : super(key: key);

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
      navigateToHome();
    }
  }

  Future<void> navigateToHome() async {
    UserRepo.customer = Customer(
      uid: user!.uid,
      email: user!.email,
      name: widget.name,
      phoneNumber: widget.phone,
      favoriteDes: [],
      imageUrl: '',
    );
    UserRepo userRepo = UserRepo();
    await userRepo.createUser(UserRepo.customer.uid);
    Get.offAllNamed('/mainContainer');
    showSnackbar(
        'Register successful', 'Welcome ${UserRepo.customer.name}', true);
  }

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
    //   return Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       title: Text(
    //         'Verify Email',
    //         style: TextStyle(
    //           color: Colors.black,
    //         ),
    //       ),
    //       backgroundColor: Colors.white,
    //     ),
    //     body: Center(
    //       child: Text('An email has been sent to ur email please verify'),
    //     ),
    //   );
    // }
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
                  child: Text(
                    'Resend email',
                    style: TextStyle(
                      fontSize: AppValue.AuthFontSize + 3.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  user!.sendEmailVerification();
                  showActionSnackBar(
                      context, 'Email verified has been resended');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
