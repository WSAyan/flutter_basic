import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_basic/data/user.dart';
import 'package:flutter_basic/network/helper.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'package:flutter_basic/utils/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserScreen extends StatefulWidget {
  UserScreen();

  UserScreen.fromUserScreen(int userId);

  @override
  UserState createState() => UserState();
}

class UserState extends State<UserScreen> {
  Future<SingleUserResponse> futureUser;

  @override
  Widget build(BuildContext context) {
    final int userId = ModalRoute.of(context).settings.arguments;
    futureUser = HttpRepository().getSingleUser(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.USER_SCREEN_TITLE),
      ),
      body: buildUserData(),
    );
  }

  Widget buildUserData() {
    return FutureBuilder<SingleUserResponse>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data.data;
            return Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ClipOval(
                        child:
                            Image.network(user.avatar, height: 100, width: 100)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${user.email}",
                      style: TextStyle(fontSize: 14.0),
                    )
                  ],
                ));
          }

          return Center(child: CommonAppWidgets.makeCommonLoader());
        });
  }
}
