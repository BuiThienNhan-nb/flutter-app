import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home/destination_detail/add_comment.dart';
import 'package:flutter_app/services/usersRepo.dart';
import 'package:flutter_app/utils/snack_bar_widget.dart';

class AllComment extends StatefulWidget {
  final String nameDes;
  const AllComment({Key? key, required this.nameDes}) : super(key: key);

  @override
  State<AllComment> createState() => _AllCommentState();
}

class _AllCommentState extends State<AllComment> {
  var databaseRef = FirebaseDatabase.instance.reference().child('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            flex: 8,
            child: FirebaseAnimatedList(
              // physics: NeverScrollableScrollPhysics(),
              // shrinkWrap: true,
              query: databaseRef.child('image: ${widget.nameDes}'),
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return ListTile(
                  title: updateComment(snapshot.value['name'])
                      ? Text(snapshot.value['name'])
                      : Text(UserRepo.customer.name.toString()),
                  subtitle: Text(snapshot.value['comment']),
                  trailing: myPopMenuButton(snapshot.key, snapshot.value['id']),
                  leading: CircleAvatar(
                    backgroundImage: updateImage(snapshot.value['image'])
                        ? NetworkImage('${snapshot.value['image']}')
                        : NetworkImage('${UserRepo.customer.imageUrl}'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: AddComment(nameDes: widget.nameDes),
            flex: 2,
          )
        ],
      )),
    );
  }

  Widget myPopMenuButton(var key, var uid) {
    return IconButton(
      onPressed: () {},
      icon: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text(
              'delete',
            ),
          ),
        ],
        onSelected: (value) {
          switch (value) {
            case 'delete':
              deleteComment(key, uid);
              break;
            default:
          }
        },
      ),
    );
  }

  void deleteComment(var key, var uid) {
    if (uid == UserRepo.customer.uid) {
      databaseRef.child('image: ${widget.nameDes}').child(key).remove();
      showSnackbar('Delete Success', 'Your comment has been deleted. ', true);
    } else {
      showSnackbar('Error', 'Can\'t delete other users\' comment.', false);
    }
  }

  bool updateComment(String name) {
    if (UserRepo.customer.name != name) {
      return false;
    } else {
      return true;
    }
  }

  bool updateImage(String image) {
    if (UserRepo.customer.imageUrl != image) {
      return false;
    } else {
      return true;
    }
  }
}
