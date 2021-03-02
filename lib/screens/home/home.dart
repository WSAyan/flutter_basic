import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/background/push_notification.dart';
import 'package:flutter_basic/screens/home/drawer.dart';
import 'package:flutter_basic/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  FCMHelper fcmHelper;

  @override
  void initState() {
    super.initState();

    fcmHelper = new FCMHelper(context);
    fcmHelper.handlePushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.HOME_SCREEN_TITLE),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome to",
            ),
            Text(
              "Neverland",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      drawer: SideNavDrawer(),
    );
  }
}
