import 'package:firebase_auth/firebase_auth.dart';

class Customer {
  final String uid;
  String? email = '';
  String? name = '';
  String? phoneNumber = '';

  Customer(
      {required this.uid,
      required this.email,
      required this.name,
      required this.phoneNumber});

  factory Customer.fromJson(Map<String, dynamic>? data) {
    return Customer(
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: data!['email'] as String,
        name: data['name'] as String,
        phoneNumber: data['phoneNumber'] as String);
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name, 'phoneNumber': phoneNumber};
  }
}
