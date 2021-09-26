import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/screens/authenticate/header_decoration.dart';
import 'package:flutter_app/screens/authenticate/login.dart';
import 'package:flutter_app/screens/authenticate/verify_email.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:flutter_app/utils/email_field_widget.dart';
import 'package:flutter_app/utils/password_field_widget.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';
import 'package:flutter_app/utils/text_input_field.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  final Function toggleScreen;

  const SignUp({Key? key, required this.toggleScreen}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  signUp() async {
    AuthenticationServices _auth = AuthenticationServices();
    if (_formKey.currentState!.validate()) {
      TextInput.finishAutofillContext();
      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        showSnackbar('Register Failed',
            'Password and Confirm Password are not equal', false);
        return;
      }
      dynamic result = await _auth.signUpEmail(
          _emailController.text.trim(), _passwordController.text.trim());
      if (_auth.errorMessage != '') {
        showSnackbar('Register Failed', _auth.errorMessage, false);
      }
      if (result == null) {
        return;
      } else {
        User? user = FirebaseAuth.instance.currentUser;
        UserRepo.customer = Customer(
          uid: user!.uid,
          email: user.email,
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          favoriteDes: [],
          imageUrl: '',
        );
        UserRepo userRepo = UserRepo();
        await userRepo.createUser(UserRepo.customer.uid);
        Get.to(() => VerifyEmail(),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 800));
        // User? user = FirebaseAuth.instance.currentUser;
        // UserRepo.customer = Customer(
        //   uid: user!.uid,
        //   email: user.email,
        //   name: _nameController.text.trim(),
        //   phoneNumber: _phoneController.text.trim(),
        //   favoriteDes: [],
        // );
        // UserRepo userRepo = UserRepo();
        // await userRepo.createUser(UserRepo.customer.uid);
        // Get.offAllNamed('/mainContainer');
        // showSnackbar(
        //     'Register successful', 'Welcome ${UserRepo.customer.name}', true);
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
                height: 150,
                child: HeaderWidget(150, true, Icons.person_add_alt_1_rounded),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: AutofillGroup(
                          child: Column(
                            children: [
                              Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[900],
                                ),
                              ),
                              SizedBox(height: 20),
                              TextInputField(
                                controller: _nameController,
                                hintText: 'Name',
                                textInputType: TextInputType.name,
                                icon: Icons.person,
                                typeValidation: 'name',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextInputField(
                                controller: _phoneController,
                                hintText: 'Phone Number',
                                textInputType: TextInputType.phone,
                                icon: Icons.phone,
                                typeValidation: 'phone',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              EmailFieldWidget(controller: _emailController),
                              const SizedBox(
                                height: 16,
                              ),
                              PasswordFieldWidget(
                                controller: _passwordController,
                                hintText: 'Password',
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PasswordFieldWidget(
                                controller: _confirmPasswordController,
                                hintText: 'Confirm Password',
                              ),
                              const SizedBox(
                                height: 45,
                              ),
                              ButtonWidget(text: 'Sign Up', onClicked: signUp),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have account ?"),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  TextButton(
                                    // onPressed: () => widget.toggleScreen(),
                                    onPressed: () => Get.to(
                                        () => LoginScreen(toggleScreen: () {}),
                                        transition: Transition.rightToLeft,
                                        duration: Duration(milliseconds: 800)),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(color: Colors.blue[900]),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // body: Center(

        //     // child: Form(
        //     //   key: _formKey,
        //     //   child: SingleChildScrollView(
        //     //     padding: EdgeInsets.fromLTRB(30, 400, 30, 20),
        //     //     child: AutofillGroup(
        //     //       child: Column(
        //     //         children: [
        //     //           TextInputField(
        //     //             controller: _nameController,
        //     //             hintText: 'Name',
        //     //             textInputType: TextInputType.name,
        //     //             icon: Icon(Icons.person),
        //     //             typeValidation: 'name',
        //     //           ),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           TextInputField(
        //     //             controller: _phoneController,
        //     //             hintText: 'Phone Number',
        //     //             textInputType: TextInputType.phone,
        //     //             icon: Icon(Icons.phone),
        //     //             typeValidation: 'phone',
        //     //           ),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           EmailFieldWidget(controller: _emailController),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           PasswordFieldWidget(
        //     //             controller: _passwordController,
        //     //             hintText: 'Password',
        //     //           ),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           PasswordFieldWidget(
        //     //             controller: _confirmPasswordController,
        //     //             hintText: 'Confirm Password',
        //     //           ),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           ButtonWidget(text: 'Sign Up', onClicked: signUp),
        //     //           const SizedBox(
        //     //             height: 16,
        //     //           ),
        //     //           Row(
        //     //             mainAxisAlignment: MainAxisAlignment.center,
        //     //             children: [
        //     //               Text("Already have account ?"),
        //     //               SizedBox(
        //     //                 width: 5,
        //     //               ),
        //     //               TextButton(
        //     //                 onPressed: () => widget.toggleScreen(),
        //     //                 child: Text("Login"),
        //     //               )
        //     //             ],
        //     //           )
        //     //         ],
        //     //       ),
        //     //     ),
        //     //   ),
        //     // ),

        //     ),
      ),
    );
  }
}
