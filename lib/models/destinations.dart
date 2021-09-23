import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  String uid;
  String name;
  String description;
  String imageUrl;
  int favorites;

  Destination(
      {required this.uid,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.favorites});

  factory Destination.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Destination(
      uid: doc.id,
      name: data!.containsKey('name') ? data['name'] as String : '',
      description:
          data.containsKey('description') ? data['description'] as String : '',
      imageUrl: data.containsKey('imageUrl') ? data['imageUrl'] as String : '',
      favorites: data.containsKey('favorites') ? data['favorites'] as int : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'favorites': favorites,
    };
  }
}
