import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';

class UserRepo {
  static Customer customer =
      Customer(uid: '', email: '', name: '', phoneNumber: '');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> checkExist(String uid) async {
    bool isRegistered = false;
    try {
      await _db.doc('users/$uid').get().then((doc) {
        isRegistered = doc.exists;
      });
      return isRegistered;
    } catch (e) {
      return false;
    }
  }

  Future<void> createUser(String uid) async {
    DocumentReference documentReference = _db.collection('users').doc(uid);
    return await documentReference
        .set(customer.toMap())
        .then((value) => print('User Added'))
        .catchError((error) => showSnackbar(
            'Failed', 'Create user data fail cause by $error', false));
  }

  Future<Customer> fetchUser(String uid) async {
    DocumentSnapshot documentReference =
        await _db.collection('users').doc(uid).get();

    if (documentReference.exists) {
      return Customer.fromJson(documentReference.data());
    } else {
      print('USER REPO: Fecth user failed');
      return Customer(uid: '', email: '', name: '', phoneNumber: '');
    }
  }
}
