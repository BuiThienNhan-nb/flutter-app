import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/const_values/controller.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:intl/intl.dart';

class AddComment extends StatefulWidget {
  final String nameDes;

  const AddComment({Key? key, required this.nameDes}) : super(key: key);

  @override
  _AddCommentState createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  var controlerComment = new TextEditingController();

  final databaseRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextFormField(
              cursorColor: Colors.orange,
              controller: controlerComment,
              decoration: InputDecoration(
                  labelText: 'comment', border: OutlineInputBorder()),
            ),
          ),
          IconButton(
            onPressed: () {
              if (controlerComment.text.isNotEmpty) {
                insertData(controlerComment.text, widget.nameDes);
              }
            },
            icon: Icon(
              Icons.send,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  void insertData(String comment, String nameDes) {
    String formattedDate =
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
    String keyUsers =
        databaseRef.child('users').child('destination: $nameDes').push().key;

    databaseRef
        .child('users')
        .child('destination: $nameDes')
        .child(keyUsers)
        .set({
      'comment': comment,
      'id': UserRepo.customer.uid,
      'name': UserRepo.customer.name,
      'time': formattedDate,
      'image': UserRepo.customer.imageUrl,
    });
    if (!commentController.comments.contains(widget.nameDes)) {
      databaseRef
          .child('comments')
          .child(UserRepo.customer.uid)
          .child(keyUsers)
          .set({
        'destination': widget.nameDes,
      });
      commentController.comments.add(widget.nameDes);
    }
    databaseRef.child('keys').child(UserRepo.customer.uid).child(keyUsers).set({
      'key': keyUsers,
    });
    if (!commentController.keys.contains(keyUsers)) {
      commentController.keys.add(keyUsers);
    }
    int i = 0;
    controlerComment.clear();
  }
}
