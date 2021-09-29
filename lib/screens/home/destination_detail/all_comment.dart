import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class AllComment extends StatefulWidget {
  final String nameDes;
  const AllComment({Key? key, required this.nameDes}) : super(key: key);

  @override
  State<AllComment> createState() => _AllCommentState();
}

class _AllCommentState extends State<AllComment> {
  final databaseRef = FirebaseDatabase.instance.reference().child('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        // scrollDirection: Axis.vertical,
        // physics: NeverScrollableScrollPhysics(),
        query: databaseRef.child('image: ${widget.nameDes}'),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          // var x = snapshot.value['name'];
          print(widget.nameDes);
          return ListTile(
            title: Text(snapshot.value['name']),
            subtitle: Text(snapshot.value['comment']),
            trailing: Icon(Icons.delete),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('${Text(snapshot.value['image'])}'),
            ),
          );
        },
      )),
    );
  }
}
