import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/services/usersRepo.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage = '';

  //sign in with email
  Future signInEmail(String _email, String _password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
        return null;
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user!';
        return null;
      }
    }
  }

  Future signUpEmail(String _email, String _password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email';
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    UserRepo.customer = Customer(
      uid: '',
      email: '',
      name: '',
      phoneNumber: '',
      imageUrl: '',
      favoriteDes: [],
      favoritePost: [],
    );
  }
}
