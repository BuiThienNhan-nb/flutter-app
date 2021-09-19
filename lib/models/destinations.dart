import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  String uid;
  String name;
  String description;
  String imageUrl;

  Destination(
      {required this.uid,
      required this.name,
      required this.description,
      required this.imageUrl});

  factory Destination.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data();
    return Destination(
      uid: doc.id,
      name: data!['name'] as String,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'imageUrl': imageUrl};
  }
}
