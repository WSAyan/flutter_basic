import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic/screens/home/drawer.dart';
import 'package:flutter_basic/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.HOME_SCREEN_TITLE)),
      body: Center(child: Text('My Page!')),
      drawer: SideNavDrawer(),
    );
  }
}
