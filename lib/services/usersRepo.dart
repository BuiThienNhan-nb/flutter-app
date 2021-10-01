import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';

class UserRepo {
  static Customer customer = Customer(
      uid: '',
      email: '',
      name: '',
      phoneNumber: '',
      favoriteDes: [],
      imageUrl: '',
      birthday: '');
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

  Future<void> deleteUser(String uid) async {
    // DocumentReference documentReference = _db.collection('users').doc(uid);
    // return await documentReference
    //     .set(customer.toMap())
    //     .then((value) => print('User Added'))
    //     .catchError((error) => showSnackbar(
    //         'Failed', 'Create user data fail cause by $error', false));
    return await _db.collection('users').doc(uid).delete();
  }

  Future<Customer> fetchUser(String uid) async {
    DocumentSnapshot documentReference =
        await _db.collection('users').doc(uid).get();

    if (documentReference.exists) {
      return Customer.fromJson(
          documentReference.data() as Map<String, dynamic>?);
    } else {
      print('USER REPO: Fecth user failed');
      return Customer(
        uid: '',
        email: '',
        name: '',
        phoneNumber: '',
        imageUrl: '',
        favoriteDes: [],
        birthday: '',
      );
    }
  }

  // Stream<List<String>> listUserFavDesIdStream(String id) {
  //   return _db
  //       .collection('destinations')
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<Destination> list = [];
  //     query.docs.forEach((element) {
  //       //add data
  //       list.add(Destination.fromJson(element));
  //     });
  //     return list;
  //   });
  // }
}
