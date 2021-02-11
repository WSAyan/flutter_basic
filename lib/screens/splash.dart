import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_basic/local/shared_pref.dart';
import 'package:flutter_basic/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      SharedPrefHelper().getAuthToken().then((value) => checkAuth(value));
    });
  }

  void checkAuth(String token) {
    if (token.isEmpty) {
      Navigator.of(context).pushNamed(Routes.LOGIN);
    } else {
      Navigator.of(context).pushNamed(Routes.USERS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(AppStrings.APP_NAME),
      ),
    );
  }
}
