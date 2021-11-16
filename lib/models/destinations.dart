import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  String uid;
  String name;
  String description;
  String imageUrl;
  List<String> imagesUrl;
  String videoUrl;
  int favorites;
  GeoPoint geoPoint;

  Destination(
      {required this.uid,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.imagesUrl,
      required this.favorites,
      required this.videoUrl,
      required this.geoPoint});

  factory Destination.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Destination(
      uid: doc.id,
      name: (data!.containsKey('name') && data['name'] != null)
          ? data['name'] as String
          : '',
      description:
          (data.containsKey('description') && data['description'] != null)
              ? data['description'] as String
              : '',
      imageUrl: (data.containsKey('imageUrl') && data['imageUrl'] != null)
          ? data['imageUrl'] as String
          : '',
      videoUrl: (data.containsKey('videoUrl') && data['videoUrl'] != null)
          ? data['videoUrl'] as String
          : '',
      favorites: (data.containsKey('favorites') && data['favorites'] != null)
          ? data['favorites'] as int
          : 0,
      geoPoint: (data.containsKey('location') && data['location'] != null)
          ? data['location']
          : GeoPoint(0, 0),
      imagesUrl: (data.containsKey('imagesUrl') && data['imagesUrl'] != null)
          ? (data['imagesUrl'] as List<dynamic>).cast<String>()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'imagesUrl': imagesUrl,
      'videoUrl': videoUrl,
      'favorites': favorites
    };
  }
}
