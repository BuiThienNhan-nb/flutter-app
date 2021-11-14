import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/services/authentication.dart';
import 'package:flutter_app/utils/button_widget.dart';
import 'package:flutter_app/utils/password_field_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  // final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _retypeNewPasswordController = TextEditingController();

  @override
  void dispose() {
    // _passwordController.dispose();
    _newPasswordController.dispose();
    _retypeNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    signOut() async {
      AuthenticationServices _auth = AuthenticationServices();
      await _auth.signOut();
      Get.offAllNamed('/login');
    }

    changePassword() async {
      if (_formKey.currentState!.validate()) {
        try {
          await currentUser!.updatePassword(_newPasswordController.text.trim());
          // Get.defaultDialog(
          //     title: "Changing password...",
          //     content: Container(height: 40, color: Colors.blue));
          signOut();
        } catch (error) {}
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.varelaRound(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Palette.myLightGrey,
        child: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PasswordFieldWidget(
                        controller: _newPasswordController,
                        hintText: "New password",
                        currentPassword: '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PasswordFieldWidget(
                        controller: _retypeNewPasswordController,
                        hintText: "Retype new password",
                        currentPassword: _newPasswordController.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: ButtonWidget(
                        text: "Change password",
                        onClicked: changePassword,
                        color: Palette.orange,
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
