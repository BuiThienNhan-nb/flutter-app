import 'package:flutter/material.dart';
import 'package:flutter_app/const_values/palette.dart';
import 'package:flutter_app/services/usersRepo.dart';

class HomeStatusBar extends StatelessWidget {
  const HomeStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${UserRepo.customer.name}!',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Have a good day <3',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
        Spacer(
          flex: 7,
        ),
        Icon(
          Icons.notifications,
          color: Colors.grey,
        ),
        Spacer(
          flex: 1,
        ),
        CircleAvatar(
          child: Icon(Icons.person),
        ),
      ],
    );
  }
}
