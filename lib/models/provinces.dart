import 'package:cloud_firestore/cloud_firestore.dart';

class Province {
  String uid;
  String name;

  Province({required this.uid, required this.name});

  factory Province.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Province(
      uid: doc.id,
      name: data!.containsKey('name') ? data['name'] as String : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
