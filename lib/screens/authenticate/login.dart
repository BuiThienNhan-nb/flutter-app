import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/screens/authenticate/header_decoration.dart';
import 'package:flutter_app/screens/authenticate/signUp.dart';
import 'package:flutter_app/screens/authenticate/verify_email.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:flutter_app/utils/email_field_widget.dart';
import 'package:flutter_app/utils/password_field_widget.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleScreen;

  const LoginScreen({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  navigateToHome() async {
    UserRepo userRepo = UserRepo();
    await userRepo
        .fetchUser(FirebaseAuth.instance.currentUser!.uid)
        .then((value) => UserRepo.customer = value);
    Get.offAllNamed('/mainContainer');
    showSnackbar(
        "Login succesful", 'Welcome back ${UserRepo.customer.name}', true);
  }

  login() async {
    AuthenticationServices _auth = AuthenticationServices();
    if (_formKey.currentState!.validate()) {
      TextInput.finishAutofillContext();
      dynamic result = await _auth.signInEmail(
          _emailController.text.trim(), _passwordController.text.trim());
      if (_auth.errorMessage != '') {
        showSnackbar('Login Failed', _auth.errorMessage, false);
      }
      if (result == null) {
      } else {
        User? user = FirebaseAuth.instance.currentUser;
        UserRepo.customer = Customer(
          uid: user!.uid,
          email: user.email,
          name: user.displayName,
          phoneNumber: user.phoneNumber,
          imageUrl: '',
        );
        UserRepo userRepo = UserRepo();
        userRepo.createUser(UserRepo.customer.uid);

        //fetch user and navigate to home page here
        if (FirebaseAuth.instance.currentUser!.emailVerified)
          navigateToHome();
        else {
          Get.to(() => VerifyEmail(),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 800));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 250,
                child: HeaderWidget(250, true, Icons.login_rounded),
              ),
              SizedBox(height: 40),
              SafeArea(
                  child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        // padding: EdgeInsets.only(left: 10, right: 10),
                        child: AutofillGroup(
                          child: Column(
                            children: [
                              EmailFieldWidget(controller: _emailController),
                              const SizedBox(
                                height: 16,
                              ),
                              PasswordFieldWidget(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ButtonWidget(text: 'Login', onClicked: login),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Dont't have account ?"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    // onPressed: () => widget.toggleScreen(),

                                    onPressed: () => Get.to(
                                        () => SignUp(toggleScreen: () {}),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 800)),
                                    // onPressed: () => Get.to(() => VerifyEmail(),
                                    //     transition: Transition.rightToLeft,
                                    //     duration: Duration(milliseconds: 800)),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(color: Colors.blue[900]),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
