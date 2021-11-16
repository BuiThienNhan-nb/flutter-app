import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String uid;
  String? email = '';
  String? name = '';
  String? phoneNumber = '';
  String? imageUrl = '';
  Timestamp? birthday;
  List<String>? favoriteDes = [];
  List<String>? favoritePost = [];

  Customer({
    required this.uid,
    this.email,
    this.name,
    this.phoneNumber,
    this.imageUrl,
    this.favoriteDes,
    this.favoritePost,
    this.birthday,
  });

  factory Customer.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Customer(
      uid: doc.id,
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
      favoritePost:
          (data.containsKey('favoritePost') && data['favoritePost'] != null)
              ? (data['favoritePost'] as List<dynamic>).cast<String>()
              : [],
      birthday: (data.containsKey('birthday') && data['birthday'] != null)
          ? (data['birthday'])
          : Timestamp.fromDate(DateTime.now()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'favoriteDes': favoriteDes,
      'favoritePost': favoritePost,
      'birthday': birthday,
    };
  }
}
