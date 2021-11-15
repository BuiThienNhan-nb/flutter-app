import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/models/customers.dart';
import 'package:flutter_app/models/destinations.dart';
import 'package:get/get.dart';

class Post {
  String uid;
  String content;
  Rx<Customer> customer;
  Rx<Destination> destination;
  Timestamp postDate;
  int favorites;

  Post({
    required this.uid,
    required this.content,
    required this.customer,
    required this.destination,
    required this.postDate,
    required this.favorites,
  });

  factory Post.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return Post(
      uid: doc.id,
      content: (data!.containsKey('content') && data['content'] != null)
          ? data['content'] as String
          : '',
      postDate: (data.containsKey('postDate') && data['postDate'] != null)
          ? data['postDate'] as Timestamp
          : Timestamp.fromDate(DateTime.now()),
      favorites: (data.containsKey('favorites') && data['favorites'] != null)
          ? data['favorites'] as int
          : 0,
      customer: (data.containsKey('userId') && data['userId'] != null)
          ? new Customer(uid: data['userId'] as String).obs
          : new Customer(uid: 'uid').obs,
      destination: (data.containsKey('desId') && data['desId'] != null)
          ? new Destination(
              uid: data['desId'] as String,
              name: '',
              description: '',
              imageUrl: '',
              favorites: 0,
              videoUrl: '',
              geoPoint: GeoPoint(0, 0),
            ).obs
          : new Destination(
              uid: '',
              name: '',
              description: '',
              imageUrl: '',
              favorites: 0,
              videoUrl: '',
              geoPoint: GeoPoint(0, 0),
            ).obs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'postDate': postDate,
      'favorites': favorites,
      'userId': customer.value.uid,
      'desId': destination.value.uid,
    };
  }
}
