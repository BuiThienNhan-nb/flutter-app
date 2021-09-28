import 'package:firebase_auth/firebase_auth.dart';

class Customer {
  final String uid;
  String? email = '';
  String? name = '';
  String? phoneNumber = '';
  String? imageUrl = '';
  List<String>? favoriteDes = [];

  Customer({
    required this.uid,
    this.email,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.favoriteDes,
  });

  factory Customer.fromJson(Map<String, dynamic>? data) {
    return Customer(
      uid: FirebaseAuth.instance.currentUser!.uid,
      // email: data!['email'] as String,
      email: (data!.containsKey('email') && data['email'] != null)
          ? data['email'] as String
          : '',
      name: (data.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      phoneNumber:
          (data.containsKey('phoneNumber') && data['phoneNumber'] != null)
              ? data['phoneNumber'] as String
              : '',
      imageUrl: (data.containsKey('imageUrl') && data['imageUrl'] != null)
          ? data['imageUrl'] as String
          : '',
      favoriteDes:
          (data.containsKey('favoriteDes') && data['favoriteDes'] != null)
              ? (data['favoriteDes'] as List<dynamic>).cast<String>()
              : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'favoriteDes': favoriteDes,
    };
  }
}
