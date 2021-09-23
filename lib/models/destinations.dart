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
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Destination(
      uid: doc.id,
      name: data!.containsKey('name') ? data['name'] as String : '',
      description:
          data.containsKey('description') ? data['description'] as String : '',
      imageUrl: data.containsKey('imageUrl') ? data['imageUrl'] as String : '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description, 'imageUrl': imageUrl};
  }
}
