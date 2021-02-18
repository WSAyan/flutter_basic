import 'package:flutter/material.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserScreen extends StatefulWidget {
  UserScreen();

  UserScreen.fromUserScreen(User user);

  @override
  UserState createState() => UserState();
}

class UserState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    Fluttertoast.showToast(msg: user.firstName);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.USER_SCREEN_TITLE),
      ),
    );
  }
}
