import 'package:flutter/material.dart';
import 'package:flutter_basic/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.REGISTER_SCREEN_TITLE),
      ),
      body: Container(),
    );
  }
}
