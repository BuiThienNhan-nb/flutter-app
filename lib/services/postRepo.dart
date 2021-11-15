import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/models/post.dart';
import 'package:flutter_app/services/usersRepo.dart';

import 'destinationsRepo.dart';

class PostRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Post>> postStream() {
    return _db
        .collection('posts')
        // .orderBy('postDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Post> list = [];
      query.docs.forEach((element) async {
        // add data
        list.add(Post.fromJson(element));
      });
      return list;
    });
  }

  Future<bool> updateUserFavPost(Post post, bool isLiked) async {
    bool _success = false;
    if (!isLiked) {
      UserRepo.customer.favoritePost!.add(post.uid);
      await _db
          .collection('users')
          .doc('${UserRepo.customer.uid}')
          .update({'favoritePost': UserRepo.customer.favoritePost});
      await _db
          .collection('posts')
          .doc('${post.uid}')
          .update({'favorites': post.favorites + 1});
      _success = true;
    } else {
      UserRepo.customer.favoritePost!.remove(post.uid);
      await _db
          .collection('users')
          .doc('${UserRepo.customer.uid}')
          .update({'favoritePost': UserRepo.customer.favoritePost});
      await _db
          .collection('posts')
          .doc('${post.uid}')
          .update({'favorites': post.favorites - 1});
      _success = true;
    }
    return _success;
  }

  Future<void> addPost(Post post) {
    return _db.collection('posts').add(post.toMap()).then((value) {
      destinationController.fetchEntirePost();
    });
  }
}
