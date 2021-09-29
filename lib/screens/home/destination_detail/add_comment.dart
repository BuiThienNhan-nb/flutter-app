import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    dynamic currentTime = DateFormat.jm().format(DateTime.now());

    String key = databaseRef.child('users').child('image: $nameDes').push().key;
    databaseRef.child('users').child('image: $nameDes').child(key).set({
      'comment': comment,
      'id': UserRepo.customer.uid,
      'name': UserRepo.customer.name,
      'time': currentTime,
      'image': UserRepo.customer.imageUrl,
    });
    controlerComment.clear();
  }
}
