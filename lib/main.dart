import 'package:flutter/material.dart';
import 'package:flutter_basic/screens/auth/register.dart';
import 'package:flutter_basic/utils/constants.dart';
import 'screens/auth/login.dart';
import 'screens/splash.dart';

void main() {
  runApp(BasicApp());
}

class BasicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.SPLASH,
      routes: {
        Routes.SPLASH: (context) => SplashScreen(),
        Routes.LOGIN: (context) => LoginScreen(),
        Routes.REGISTER: (context) => RegisterScreen(),
      },
    );
  }
}
